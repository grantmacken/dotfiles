local M = {}
local plugin =  'mini.completion'
local util = require('my.util')
local nmap_leader = util.nmap_leader
M.setup = require(plugin).setup
-- plugin setup config options
-- not on buffenter but for LSP attach
M.config = {
  lsp_completion = {
    source_func = 'omnifunc',
    auto_setup = false
  }
}

-- plugin leader mappings
M.mappings = function()
-- local nmap_leader = util.nmap_leader
-- b is for 'buffer'
-- nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
end

return M
