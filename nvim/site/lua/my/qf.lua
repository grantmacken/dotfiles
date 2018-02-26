local _M = {}

local cjson = require('cjson')
local util = require('my.util')
local fs = require('my.fs')
local api = vim.api

function _M.rotateNext()
  local bNext, err = pcall( api.nvim_command,'cnext')
  if not cNext then
    util.echom( ' - err: ' .. err)
    local bFirst, err = pcall( api.nvim_command,'cfirst')
  end
end

function _M.rotatePrev()
  local bNext, err = pcall( api.nvim_command,'cprevious')
  if not cNext then
     util.echom( ' - err: ' .. err)
    local bFirst, err = pcall( api.nvim_command,'clast')
  end
end

return _M
