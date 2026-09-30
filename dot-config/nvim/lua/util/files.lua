local M = {}
M.version = "0.1.0"
M.description = [[
 functions for working with files and paths
 - overview: if other modules need to work with files and paths, they can use this module for common functionality
 - scope: when required by other modules, they are local private functions
  and not exposed as public functions in that module's interface
 - usage: other lua modules
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] todo task 1
 - [ ] todo task 3
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

--- in buffer context,  get the relative path of the current buffer to the project root
--- @return string relative path from project root
local get_relative_path = function()
  local base = vim.fs.root(0, '.git') or vim.fn.getcwd()
  local bufID = vim.api.nvim_get_current_buf()
  local target = vim.api.nvim_buf_get_name(bufID)
  local opts = {}
  local relative_path = vim.fs.relpath(base, target, opts) or ''
  return relative_path
end

M.get_relative_path = get_relative_path

return M
