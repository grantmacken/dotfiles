local M          = {}
M.version        = "0.1.0"
M.description    = [[
 module: arglist - management for project specific arglists
  - Each project has its own arglist, stored in a .arglist file in the project root
  - The arglist is managed with user commands and keymaps for adding, deleting, and navigating the arglist
  - The arglist can be saved to the .arglist file with a user command
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [x] add current file to arglist
 - [x] delete current file from arglist
 - [x] when aglist is added to or deleted, save the arglist to file in project root
 - [x] show arglist in a show window buffer, with each file on a separate line
 - [x] buffer-local cmd  for show buffer: `gf` will open file in main window
 - [x] load data form .arglist file into arglist when project is opened
]]

M.references     = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]


local files = require('util.files')




local show   = function()
  local bufName = 'bufScratchArglist'
  local data = vim.fn.argv()
  if #data == 0 then
    vim.notify('Arglist is empty', vim.log.levels.WARN)
    return
  end
  local bufID = require('show').data(bufName, data, {})
  vim.keymap.set('n', 'gf', function()
    local file = vim.fn.expand('<cfile>')
    if file == '' then return end
    -- Target your specific window ID
    local target_win = vim.fn.win_getid(1)
    if target_win and vim.api.nvim_win_is_valid(target_win) then
      vim.api.nvim_set_current_win(target_win)
      vim.cmd('edit ' .. vim.fn.fnameescape(file))
    else
      vim.cmd('edit ' .. vim.fn.fnameescape(file))
    end
  end, { buffer = bufID, desc = 'Custom gf for scratch buffers' })
end

local load   = function()
  local cwd = vim.fn.getcwd()
  local arglist_file = cwd .. '/.arglist'
  if vim.fn.filereadable(arglist_file) == 1 then
    local ok, arglist = pcall(vim.fn.readfile, arglist_file, 'b')
    if not ok then
      vim.notify('Error loading arglist: ' .. arglist, vim.log.levels.ERROR)
      return nil, arglist
    end
    local _, _ = pcall(vim.cmd.argdelete, '*')
    for _, filename in ipairs(arglist) do
      vim.cmd.argadd(filename)
    end
    vim.notify('Arglist loaded from ' .. arglist_file, vim.log.levels.INFO)
  else
    vim.notify('No .arglist file found in ' .. cwd, vim.log.levels.WARN)
  end
end

local save   = function()
  local arglist = vim.fn.argv()
  local cwd = vim.fn.getcwd()
  local arglist_file = cwd .. '/.arglist'
  local ok, err = pcall(vim.fn.writefile, arglist, arglist_file, 'b')
  if not ok then
    vim.notify('Error saving arglist: ' .. err, vim.log.levels.ERROR)
    return nil, err
  end
  vim.notify('Arglist saved to ' .. arglist_file, vim.log.levels.INFO)
end

--- add the current file to the arglist
--- @return nil
local add    = function()
  local relative_path = files.get_relative_path()
  vim.cmd.argadd(relative_path)
  vim.cmd.argdedupe() -- remove duplicates from the arglist
  local _, _ = pcall(vim.cmd.ArglistSave)
  --save()                   -- save the arglist to the .arglist file
end

--- add the current file to the arglist
--- @return nil
local delete = function()
  local relative_path = files.get_relative_path()
  local _, _ = pcall(vim.cmd.argdelete, relative_path)
  local _, _ = pcall(vim.cmd.ArglistSave)
end

local nav    = function(count)
  local arglen = vim.fn.argc()
  if arglen == 0 then
    return
  end
  local next = (vim.fn.argidx() + count) % arglen
  if next < 0 then
    next = next + arglen
  end
  vim.cmd(next + 1 .. 'argu')
end

M.add        = add
M.delete     = delete
M.save       = save
M.show       = show
M.load       = load --  ../../plugin/22_args.lua
M.nav        = nav
return M
