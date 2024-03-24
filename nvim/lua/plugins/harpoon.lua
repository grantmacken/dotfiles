local M = {}
M.name = 'harpoon'
local util = require('my.util')
local nmap_leader = util.nmap_leader

-- plugin setup config options
M.config = {
    settings = {
    save_on_toggle = true,
  }
}

-- plugin leader mappings
M.mappings = function( plugin )
local harpoon = require("harpoon")
-- h is for 'harpoon'
nmap_leader('ha',function()harpoon:list():append() end,'Append',{})
-- nmap_leader('hm', function() plugin.ui:toggle_quick_menu(plugin:list()) end ,'[harpoon] Menu')
-- nmap_leader('hp', function() plugin:list():prev() end,'[harpoon] Previous')
-- nmap_leader('hn', function() plugin:list():next() end,'[harpoon] Next')
-- nmap_leader('h1', function() plugin:list():select(1) end,'[harpoon] One')
-- nmap_leader('h2', function() plugin:list():select(2) end,'[harpoon] Two')
-- nmap_leader('h3', function() plugin:list():select(3) end,'[harpoon] Three')
-- nmap_leader('h4', function() plugin:list():select(4) end,'[harpoon] Four')
end

return M
