local M = {}
M.version = "0.1.0"
M.description = [[ module: arglist - management for project specific arglists
  - Each project has its own arglist, stored in a .arglist file in the project root
  - A existing arglist is cleared when loaded when a new tabpage is opened,
    and the saved arglist is loaded for the tab tabpage
  - The arglist is managed with user commands and keymaps for adding, deleting, and navigating the arglist
  - The arglist can be saved to the .arglist file with a user command
## Arglist Setup
  - clear existing arglist for the tabpage to create a fresh arglist
  - read the .arglist file in the project root
  - prepend the cwd to each file in the arglist
  - set the arglist to the project specific files
  - create user commands for loading and saving the arglist
  - create keymaps for navigating the arglist and managing it
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] Come backe to this with show window
 - [ ] todo task 3
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

-- local commands = {
--  -- 'ArglistClear',
--  -- 'ArglistLoad',
-- --  'ArglistSave',
--    'ArglistList',
-- --  'ArglistEdit',
--   --'ArglistAddCurrent',
--   -- 'ArglistDeleteCurrent',
-- }
-- ---@param path string
-- ---@return string relative path from cwd
-- local get_relative_path = function(path)
--   local cwd = vim.fn.getcwd()
--   local res = path:gsub(cwd .. '/', '')
--   return res
-- end
--
--
--
--
--
-- local load = function()
--   local arglist = vim.fn.readfile(vim.fn.getcwd() .. '/.arglist')
--   for _, file in ipairs(arglist) do
--     local ok, err = pcall(vim.cmd.argadd, file)
--     if not ok then
--       return nil, err
--     end
--   end
--   return arglist
-- end
--
-- local save = function()
--   local filepath = vim.fn.getcwd() .. '/.arglist'
--   local tbl = vim.fn.argv()
--   vim.notify('Saving arglist to ' .. filepath, vim.log.levels.INFO)
--   vim.notify(vim.inspect(tbl), vim.log.levels.DEBUG)
--   vim.fn.writefile(tbl, filepath, 'b')
-- end
--
--
-- M.listIntoQf = function()
--   local list = vim.fn.argv()
--   if type(list) ~= 'table' then
--     vim.notify('Arglist is empty', vim.log.levels.WARN)
--     return
--   end
--   if #list > 0 then
--     local qf_items = {}
--     for _, filename in ipairs(list) do
--       table.insert(qf_items, {
--         filename = filename,
--         lnum = 1,
--         text = filename
--       })
--     end
--     vim.fn.setqflist(qf_items, 'r')
--     vim.cmd.copen()
--   end
-- end
--
-- -- open arglist file for this project in a new buffer for editing
-- M.edit = function()
--   local filepath = vim.fn.getcwd() .. '/.arglist'
--   -- create the file if it doesn't exist
--   if vim.fn.filereadable(filepath) == 0 then
--     vim.fn.writefile({}, filepath)
--   end
--   vim.cmd('edit ' .. filepath)
-- end
--


return M
