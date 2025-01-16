-- Module Keymap Helper Functions
M = {}

local keymap = function(mode, keys, cmd, desc, opts)
  opts = opts or {}
  opts.desc = desc
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, keys, cmd, opts)
end


local nMap    = function(keys, rhs, desc, opts)
  keymap('n', keys, rhs, desc, opts)
end

local niMap    = function(keys, rhs, desc, opts)
  keymap({ "n", "i" }, keys, rhs, desc, opts)
end


local nvMap    = function(keys, rhs, desc, opts)
  keymap({ "n", "v" }, keys, rhs, desc, opts)
end

local tMap    = function(keys, rhs, desc, opts)
  keymap('t', keys, rhs, desc, opts)
end

local nxoMap  = function(keys, rhs, desc, opts)
  keymap({ "n", "x", "o" }, keys, rhs, desc, opts)
end

local iMap    = function(keys, rhs,desc, opts)
  keymap('i', keys, rhs, desc, opts)
end

-- local xLeader = function(suffix, rhs, desc, opts)
--   leader('x', suffix, rhs, desc, opts)
-- end

-- Create `<Leader>` mappings
local leader  = function(mode, suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set(mode, '<Leader>' .. suffix, rhs, opts)
end

local nLeader = function(suffix, rhs, desc, opts)
  leader('n', suffix, rhs, desc, opts)
end

local nvLeader = function(suffix, rhs, desc, opts)
  leader({ "n", "v" }, suffix, rhs, desc, opts)
end

M.nLeader     = nLeader
M.nMap        = nMap
M.niMap       = niMap
M.nxoMap      = nxoMap
M.iMap        = iMap
M.tMap        = tMap
M.nvMap       = nvMap
M.nvLeader    = nvLeader
return M
