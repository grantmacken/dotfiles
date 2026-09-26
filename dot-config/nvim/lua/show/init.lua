local M = {}
M.version = "0.1.0"
M.description = [[
 Manage a dedicated show window for a project Neovim instance and display named buffers in it.
 - overview: routes data and commands to reusable named buffers shown in the show window
 - scope: owns show-window, buffer, and channel coordination; not user commands, keymaps, or test wiring
 - usage: require('show') and call show.data(bufName, data, opts) or show.run(bufName, cmd)
 - buffer kind: the bufName prefix selects the buffer kind,
   which determines how the data is handled and displayed in the show window:
   - bufScratch{NameSuffix} => buffers for displaying data as markdown lists, tables or other data
   - bufEdit{NameSuffix}    =>  buffers for fetching, editing and posting data
   - bufTask{NameSuffix}    =>  task buffer for sending shell commands to a channel and displaying output
   - bufShell{NameSuffix}   =>  interactive shell buffer
   the bufType with the NameSuffix provides a unique handle for buffer.
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation =
[[
  - [ ] Reuse named buffers and the show window for repeated show.data() calls.
  - [ ] Keep each bufType{Name} mapped to the same bufID for the project instance.
  - [ ] Move show state from tab-local storage to project-instance global storage.
  - [ ] Keep the visual winbar when replacing the buffer shown in the show window.
  - [ ] Send the requested shell command from show.run() to the target buffer channel.
  - [ ] Handle bufShell buffers in show.data() or reject them with a clear error.
  - [ ] Add test coverage for show.run(), invalid names, and bufEdit/bufTask behavior.
  - [ ] Remove temporary plugin/30_show.lua wiring after normal startup integration.
  - [ ] Add a module logger using the new Neovim log API.
  ]]

M.references = [[
 - util.lua
 - buf.lua
 - win.lua
 - chan.lua
 - test.lua
 - ../../plugin/10_user_commands.lua
 - ../../plugin/30_show.lua
 - ../../tests/test_show_accept.lua
 - ../../tests/test_show_snapshots.lua
 - ../../../../tests/screenshots/-var-home-gmack-.config-nvim-tests-test_show_snapshots.lua---show-markdown-data
 - ../../../../tests/screenshots/-var-home-gmack-.config-nvim-tests-test_show_snapshots.lua---show-more-data
]]

local util = require('show.util')        -- utility functions for the show module
local clear_buffer = util.clear_buffer   -- clear the buffer of all lines
local append_lines = util.append_lines   -- append new lines to the buffer
local data_to_lines = util.data_to_lines -- convert data to lines of text
local buf = require('show.buf')
-- constant table of valid buffer name types
local set_buf_type = buf.set_buf_type -- param: bufName
local get_buf_id = buf.get_buf_id
local create_buffer = buf.create_buffer
local win = require('show.win')
local get_win_id = win.get_win_id
local create_show_window = win.create_show_window
local show_buffer_in_show_window = win.show_buffer_in_show_window
local chan = require('show.chan')
local has_chan = chan.has_chan
local get_chan_id = chan.get_chan_id
local create_job_id = chan.create_job_id
local log = require('show.log')

local get_buf_id_and_win_id = function(bufName)
  local bufID = get_buf_id(bufName)
  if bufID == 0 then
    bufID = create_buffer(bufName)
    if bufID == 0 then
      vim.notify(string.format("Failed to get or create buffer '%s'", bufName), vim.log.levels.ERROR)
      return 0, 0
    end
  end
  local winID = get_win_id()
  if winID == 0 then
    winID = create_show_window(bufID)
    if winID == 0 then
      vim.notify(string.format("Failed to get or create show window for buffer '%s'", bufName), vim.log.levels.ERROR)
      return bufID, 0
    end
  end
  return bufID, winID
end

M.run = function(bufName, cmd)
  -- local bufType = set_buf_artype(bufName)
  local chanID
  -- if bufType == 'bufShell' then
  local bufID, winID = get_buf_id_and_win_id(bufName)
  if bufID == 0 or winID == 0 then
    return 0
  end
  if show_buffer_in_show_window(winID, bufID) then
    vim.notify(string.format("Buffer '%s' shown in show window", bufName), vim.log.levels.DEBUG)
  else
    vim.notify(string.format("Failed to show buffer '%s' in show window", bufName), vim.log.levels.ERROR)
    return 0
  end
  chanID = get_chan_id(bufID)
  if chanID == 0 then
    chanID = create_job_id(bufID)
    if chanID == 0 then
      vim.notify(string.format("Failed to create channel for buffer '%s'", bufName), vim.log.levels.ERROR)
      return 0
    end
  end
  vim.fn.chansend(chanID, 'clear' .. "\n")
  -- vim.fn.chansend(chanID, cmd .. "\n")
  return bufID
end

--- Send data to buffer
--- @param bufName string buffer name like 'bufShellBuild', 'bufScratchLogs', 'bufTaskTest' , 'bufEditNotes'
--- @param data string|table string command to send or data to write
--- @param opts? table optional table of options
--- @return integer bufID buffer number of the buffer or zero on failure
M.data = function(bufName, data, opts)
  local bufID, winID = get_buf_id_and_win_id(bufName)
  if bufID == 0 or winID == 0 then
    return 0
  end
  if opts and opts.filetype then
    vim.api.nvim_set_option_value('filetype', opts.filetype, { buf = bufID })
  end
  local bufType = set_buf_type(bufName)
  -- Scratch Buffer: a scratch buffer for displaying readonly lines of text.
  if bufType == 'bufScratch' then
    data = data_to_lines(data) or {}
    vim.bo[bufID].modifiable = true
    if opts and opts.append then
      append_lines(bufID, data)
    else
      clear_buffer(bufID)
      append_lines(bufID, data)
    end
    vim.bo[bufID].modifiable = true
  end
  --  Edit Buffer: normal vim buffer for editing files in show window
  if bufType == 'bufEdit' then
    data = data_to_lines(data) or {}
    if opts and opts.append then
      append_lines(bufID, data)
    else
      clear_buffer(bufID)
      append_lines(bufID, data)
    end
  end

  if bufType == 'bufTask' then
    if type(data) == 'table' then
      data = table.concat(data, '\n') .. '\n'
    end
    local chanID
    if not has_chan(bufID) then
      chanID = vim.api.nvim_open_term(bufID, { force_crlf = true })
      vim.api.nvim_buf_set_var(bufID, 'channel', chanID)
    else
      chanID = get_chan_id(bufID)
    end
    -- send data to the channel
    local ok, err = pcall(vim.api.nvim_chan_send, chanID, data)
    if not ok then
      vim.notify(string.format("Failed to send data to channel %d for buffer '%s': %s", chanID, bufName,
        tostring(err)), vim.log.levels.ERROR)
      return 0
    end
    -- finally show the buffer in the show window
    if show_buffer_in_show_window(winID, bufID) then
      vim.notify(string.format("Buffer '%s' shown in show window", bufName), vim.log.levels.DEBUG)
      return bufID
    else
      vim.notify(string.format("Failed to show buffer '%s' in show window", bufName), vim.log.levels.ERROR)
      return 0
    end
  end

  -- local chanID = get_channel_id(bufName)
  -- if chanID == 0 then
  --   vim.notify(string.format("Failed to get or create channel for buffer '%s'", bufName), vim.log.levels.ERROR)
  --   return 0
  -- end
  --[[  cleared edit buffer: accept table as a list of lines to write
  - vim.fn.systemlist() returns a table of lines
  - vim.readfile() returns a table of lines
  - so allow table input for bufEdit to write multiple lines
   example vim.fn.systemlist('ls -al .')
   local data = vim.fn.systemlist('ls -al .')
   show.send('bufEditNotes', data)
  -- ]]

  return bufID
end

-- M.test = require('show.test').run

return M
