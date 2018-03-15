local _M = {}

local fs = require('my.fs')
-- local util = require('my.util')

local log = {}
log.outfile = '.logs/project.log'

local function projectLog()
 
end

function _M.log( str )
  local line =  '[' ..
  os.date("!%Y-%m-%dT%TZ") ..
  '] ' ..
  str ..
  '\n'

  fs.appendToFile( line ,log.outfile )
end

function _M.clean( str )
  local line = ''
  fs.writeFile( line ,log.outfile )
end

return _M
