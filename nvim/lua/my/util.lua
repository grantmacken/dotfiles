local M = {}



M.nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end

M.keymap = function(mode, keys, cmd, desc, opts)
  opts = opts or {}
  opts.desc = desc
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set(mode, keys, cmd, opts)
end

M.nmap = function( keys, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  if opts.silent == nil then opts.silent = true end
  vim.keymap.set('n', keys, rhs, opts)
end

M.xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end


M.get_session_name = function()
  local name = vim.fn.getcwd()
  local branch = vim.trim(vim.fn.system("git branch --show-current"))
  if vim.v.shell_error == 0 then
    return name .. '_' .. branch
  else
    return name
  end
end

-- This indicates that oil.nvim should be shown
 M.opened_with_dir_argument = function() 
  if vim.fn.argc() == 1 then
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == "directory" then return true end
  end
  return false
end

return M
