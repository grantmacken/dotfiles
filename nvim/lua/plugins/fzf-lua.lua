local M = {}
local name = 'fzf-lua'
local util = require('my.util')
local nmap_leader = util.nmap_leader
--

-- local mappings = function()
--   return
-- end


local config = {

}

M.setup = function()
  require(name).setup(config)
  -- mappings()
end


return M
