local M = {}
M.version = "0.1.0"
M.description = [[
 A brief plan outline of what the module will achieve.
 - overview: module overview which describes the module's purpose and functionality
 - scope: module scope
 - usage: how to use the module
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

M.run = function(name, opts)
  local test_type = opts and opts.type or 'accept'
  local fName = string.format('test_%s_%s.lua', name, test_type)
  local fPath = vim.fs.joinpath(vim.fn.stdpath('config'), 'tests', fName)
  if not vim.fs.stat(fPath) then
    vim.notify(string.format("Test file not found: %s", fPath), vim.log.levels.WARN)
    return nil
  end
  -- run the test command
  require('mini.test').run_file(
    fPath,
    { cwd = vim.fn.stdpath('config') }
  )
end

return M
