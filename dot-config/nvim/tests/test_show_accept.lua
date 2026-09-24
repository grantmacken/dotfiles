local test = require('mini.test')
local expect = test.expect
local child = test.new_child_neovim()
local minimal_init = vim.fs.joinpath(vim.fn.stdpath('config'), 'scripts', 'minimal_init.lua')

local T = test.new_set({
  hooks = {
    -- Start once so child.restart() has arguments to reuse.
    pre_once = function()
      child.start({ '-u', minimal_init })
    end,
    pre_case = function()
      child.restart()
      -- Load a module from dot-config/nvim/lua in the child process.
      child.lua([[M = require('show')]])
    end,
    -- Stop once all test cases are finished.
    post_once = child.stop,
  },
})

-- Test set fields define nested structure
T['show'] = test.new_set()

T['show']['has version string'] = function()
  expect.equality(type(child.lua_get('M.version')), 'string')
end

T['show']['has description string'] = function()
  expect.equality(type(child.lua_get('M.description')), 'string')
end



return T
