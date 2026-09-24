local M = {}
M.version = "0.1.0"
M.description = [[
 Project test-runner API built on mini.test.
 - overview: discovers snapshot tests and runs named accept or snapshot test files
 - scope: owns test-file discovery, filename conventions, and mini.test execution; not test cases
 - usage: plugin files require('test') and call test.runSnapshots() or test.runFile(name, opts)
]]

-- A TODO list of tasks to be completed for the module's implementation
M.implementation = [[
 - [ ] Add coverage for test type selection, default accept tests, and missing test paths.
 - [ ] Resolve snapshot discovery consistently from the configured Neovim project path.
 - [ ] Send failed accept-test results to the quickfix list.
 - [ ] Display a list of snapshot files in the bufScratchSnapshots show-window buffer.
 - [ ] Allow snapshot list display options to filter the listed items.
 - [ ] Add keybinds to accept modified snapshots from bufScratchSnapshots.
 - [ ] Add a keybind and line hover to preview snapshot files in a window.
 - [ ] Add a corresponding test file for this module under tests/.
 - [ ] Open a module and its alternate test file from either editing window.
 - [ ] Provide a function in either file to run tests for the associated module.
 - [ ] Define the test filename convention used for automatic test discovery.
]]

M.references = [[
 - https://neovim.io/doc/user/editing.html#alternate-file
 - https://neovim.io/doc/user/windows.html#preview-window
 - https://neovim.io/doc/user/vimfn.html#globpath()
 - https://github.com/echasnovski/mini.test
 - ../../plugin/19_mini.lua
 - ../../tests/test_show_accept.lua
 - ../../tests/test_show_snapshots.lua
]]

M.runSnapshots = function()
  local test_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'tests')
  if not vim.fs.stat(test_dir) then
    vim.notify(string.format("Test directory not found: %s", test_dir), vim.log.levels.WARN)
    return nil
  end
  -- run all test files in the test directory
  local opts = {
    collect = {
      find_files = function()
        return vim.fn.globpath('tests', '**/test_*_snapshots.lua', true, true)
      end,
    },
  }
  require('mini.test').run(opts)
end

M.runFile = function(name, opts)
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
