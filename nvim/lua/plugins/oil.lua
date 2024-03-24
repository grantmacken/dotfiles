local M = {}

local util = require('my.util')

-- plugin setup config options
M.config = {
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,}
  }

-- plugin leader mappings
M.mappings = function()
-- local  map_leader = util.nmap_leader	
  vim.keymap.set('n', '-', function() vim.cmd.Oil() end, { desc = '[oil] open parent directory' })
end

return M
