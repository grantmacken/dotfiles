local M = {}
M.name = 'mini.bufremove'
local util = require('my.util')
local nmap_leader = util.nmap_leader

-- plugin setup config options
M.config = {
}
-- plugin leader mappings
M.mappings = function( plugin )
-- b is for 'buffer'
 nmap_leader('bd',plugin.delete,  'Delete', {})
 nmap_leader('bw',plugin.wipeout, 'Wipeout', {})
 nmap_leader('ba','<Cmd>b#<CR>', 'Alternate', {})
 nmap_leader('bs',function()
   local buf_id = vim.api.nvim_create_buf(true, true)
   vim.api.nvim_win_set_buf(0, buf_id)
   return buf_id
 end , 'Scratch', {})
end
return M
