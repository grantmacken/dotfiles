local test = require('mini.test')
local expect = test.expect
local child = test.new_child_neovim()
local minimal_init = vim.fs.joinpath(vim.fn.stdpath('config'), 'scripts', 'minimal_init.lua')

local T = test.new_set({
  hooks = {
    pre_once = function()
      child.start({ '-u', minimal_init })
    end,
    pre_case = function()
      child.restart()
    end,
    post_once = child.stop,
  },
})


T['show markdown data'] = function()
  child.lua([=[local show = require('show')
local name = 'bufScratchTest'
local data = [[
  This is an example output
  that will be shown in a scratch buffer
]]
show.data(name, data, { filetype = 'markdown' })]=])

  expect.reference_screenshot(child.get_screenshot())
end

T['show more data'] = function()
  child.lua([=[local show = require('show')
local name = 'bufScratchTest'
local data = [[
  This is an example output
  that will be shown in a scratch buffer
  with the title 'Example Output'
]]
show.data(name, data, { filetype = 'text' })]=])

  expect.reference_screenshot(child.get_screenshot())
end


return T
