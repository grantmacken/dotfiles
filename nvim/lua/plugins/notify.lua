local M = {}
M.name = 'mini.notify'
local util = require('my.util')
local nmap_leader = util.nmap_leader

local filterout_lua_diagnosing = function(notif_arr)
  local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
  notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
  return MiniNotify.default_sort(notif_arr)
end

-- plugin setup config options
M.config = {
 content = { sort = filterout_lua_diagnosing },
 window = { config = { border = 'double' } },
}
-- plugin leader mappings
M.mappings = function()
-- local nmap_leader = util.nmap_leader
-- b is for 'buffer'
-- nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
end

return M
