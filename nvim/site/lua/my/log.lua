local _M = {}

local fs = require('my.fs')
-- local util = require('my.util')

local log = {}
log.outfile = '.logs/project.log'

function _M.log( str )
  local line = str .. '\n'
  fs.appendToFile( line ,log.outfile )
end

return _M
