local M                   = {}
M.version                 = "0.1.0"
M.description             = [[
# Window Management
 - Open or reuse a window to show the named buffer
 - There is a single show window per tab
 - The handle for the window is stored in vim.t.winID
 - The show window is created below the current window with 30% of the screen height
 - created buffers can be shown in the show window by reusing the window
  - If show window already exists, reuse it for the new buffer
  - Use show window winbar to hint buffer types shown in the window
  - More than one buffer type can be shown in the same tab show window
  - Only one buffer is visible at a time. all other buffers are hidden.
  - window options for the show window are set to:
    - scroll = 3
    - winfixheight = true
    - winfixwidth = true
    - winpinned = true
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation          = [[
 - [ ] todo task 1
 - [ ] todo task 3
]]

M.references              = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

local api                 = vim.api
local tabpage_set_var     = api.nvim_tabpage_set_var
--local set_buf_type        = require('show.buf').set_buf_type
--- get show window ID for current tabpage
--- @return integer winID window ID or zero on failure
local get_win_id          = function()
  local tabID      = vim.api.nvim_get_current_tabpage()
  local ok, windID = pcall(vim.api.nvim_tabpage_get_var, tabID, 'winID')
  if not ok then return 0 end
  return windID
end

--- @param bufID integer buffer number
--- @return integer winID window ID showing the buffer or zero on failure with error message
local create_shell_window = function(bufID)
  -- lets create a new window for the show buffer
  local oHeight = math.floor(vim.o.lines * 0.3)
  local oEnter = false -- do not enter the window after creation
  -- see h: api-win_config
  -- opts: table (optional) with keys
  local config = {
    height = oHeight,
    split = 'below',
    style = 'minimal',
    width = vim.o.columns,
    win = -1,
  }
  -- open the new window and store the window ID in vim.t.winID
  local winID = vim.api.nvim_open_win(bufID, oEnter, config)
end


--- @param bufID integer buffer number
--- @return integer winID window ID showing the buffer or zero on failure with error message
local create_show_window         = function(bufID)
  -- lets create a new window for the show buffer
  local oHeight = math.floor(vim.o.lines * 0.3)
  local oEnter = false -- do not enter the window after creation
  -- see h: api-win_config
  -- opts: table (optional) with keys
  local config = {
    height = oHeight,
    split = 'below',
    style = 'minimal',
    width = vim.o.columns,
    win = -1,
  }
  -- open the new window and store the window ID in vim.t.winID
  local winID = vim.api.nvim_open_win(bufID, oEnter, config)


  --Create an empty buffer using nvim_create_buf().
  ---Display it with nvim_open_win().
  ---Call nvim_open_term().

  local winbar_fmt = "## %{bufname('%')} ## winID [%{bufwinid('%')}] bufnr [%{bufnr('%')}] type [%{&buftype}]"
  vim.wo[winID].winbar = winbar_fmt
  vim.wo[winID].sidescrolloff = 0
  vim.wo[winID].wrap = false
  --[[ Special local window options			*local-noglobal*
  'previewwindow'	there can only be a single one
  'scroll'	specific to existing window
  'winfixbuf'	specific to existing window
  'winfixheight'	specific to existing window
  'winfixwidth'	specific to existing window
  'winpinned'	specific to existing window
--]]
  vim.wo[winID].scroll = 3 -- Number of lines to scroll with CTRL-U and CTRL-D commands
  vim.wo[winID].winfixheight = true
  vim.wo[winID].winfixwidth = true
  vim.wo[winID].winpinned = true
  local tabID = vim.api.nvim_get_current_tabpage()
  tabpage_set_var(tabID, 'winID', winID)
  vim.t.winID = winID
  return vim.t.winID
end

--@param winID integer window ID
--@param bufID integer buffer ID
--@return boolean true on success, false on failure
local show_buffer_in_show_window = function(winID, bufID)
  -- use pcall to catch errors if the window or buffer is invalid
  local ok, _ = pcall(vim.api.nvim_win_set_buf, winID, bufID)
  if not ok then
    return false
  end
  return true
end

--[[
nvim_win_set_buf({win}, {buf})                            *nvim_win_set_buf()*
Sets the current buffer in a window.
Note: As a side-effect, this executes |BufEnter| and |BufLeave|
--]]

M.get_win_id                 = get_win_id
M.create_show_window         = create_show_window
M.create_shell_window        = create_shell_window
M.show_buffer_in_show_window = show_buffer_in_show_window


return M
