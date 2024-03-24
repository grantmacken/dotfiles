local M = {}
M.name = ''
local util = require('my.util')
local nmap_leader = util.nmap_leader
-- plugin setup config options
M.config = {
}
-- plugin leader mappings
M.mappings = function()
-- local nmap_leader = util.nmap_leader	
-- b is for 'buffer'
-- nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
end

return M
