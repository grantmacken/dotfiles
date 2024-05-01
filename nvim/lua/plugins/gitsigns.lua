local M = {}
local name = 'gitsigns'
local util = require('my.util')
local nmap_leader = util.nmap_leader
--

-- local mappings = function()
--   return
-- end

local signs = {
  add = { text = "▎" },
  change = { text = "▎" },
  delete = { text = "" },
  topdelete = { text = "" },
  changedelete = { text = "▎" },
  untracked = { text = "▎" },
}

local config = {
  attach_to_untracked = false,
  signs = signs,
  -- on_attach = on_attach
}

M.setup = function()
  require("gitsigns").setup(config)
  -- mappings()
end


return M
