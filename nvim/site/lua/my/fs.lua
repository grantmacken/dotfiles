local _M = {}

local uv  = require('luv')
-- https://github.com/luvit/luv/blob/eb87f736ce4398252e3573b153beb5e790b1f0e1/tests/test-fs.lua
-- http://docs.libuv.org/en/v1.x/fs.html

function _M.cwd()
  return assert(uv.fs_realpath('./'))
end

function _M.open(f)
  return uv.fs_open(f, 'r', tonumber('644', 8))
end

function _M.chunk(fd)
local stat = assert(uv.fs_fstat(fd))
local chunk = assert(uv.fs_read(fd, stat.size, 0))
assert(uv.fs_close(fd))
return chunk
end

function _M.writeFile(s,f)
  local fd   = assert(uv.fs_open(f, 'w', 438))
  assert(uv.fs_write(fd,s, -1))
  assert(uv.fs_close(fd))
  return ''
end

function _M.appendToFile(s,f)
  local fd   = assert(uv.fs_open(f, 'a', 438))
  assert(uv.fs_write(fd,s, -1))
  assert(uv.fs_close(fd))
  return ''
end

return _M
