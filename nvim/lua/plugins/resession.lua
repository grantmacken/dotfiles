local M = {}
local plugin =  'resession'
local util = require('my.util')
local nmap_leader = util.nmap_leader

M.setup = require(plugin).setup

-- plugin setup config options
M.config = {
  autosave = {
    enabled = true,
    interval = 60,
    notify = true,
  },
}
-- plugin leader mappings
M.mappings = function()
-- s is for 'session'
local opts = { noremap = true, silent = true }
nmap_leader("ss", require(plugin).save  , '[Session] save' ,opts )
nmap_leader("sl", require(plugin).load  , '[Session] load' ,opts )
nmap_leader("sd", require(plugin).delete  , '[Session] delete' ,opts )
end

M.autocommands = function()
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    -- Always save a special session named "last"
    resession.save("last")
  end,
})
end

return M
