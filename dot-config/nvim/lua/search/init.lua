local M = {}
M.version = "0.1.0"
M.description = [[
 - description: A module for searching text in files using grep
 - scope: module scope
 - usage: how to use the module
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] grep function implementation
]]

M.references = [[
 - reference 1 url to gh issue or discussion
 - reference 2 file path to local documentation
]]

M.grepInputIntoQf = function()
  vim.ui.input({ prompt = 'Grep ' }, function(pattern)
    if pattern then
      --  ripgrep is the default grepprg
      vim.cmd("silent grep! " .. vim.fn.fnameescape(pattern))
      vim.cmd("copen")
    else
      vim.notify("Search pattern is required", vim.log.levels.ERROR)
    end
  end)
end

return M
