local M = {}

local name = 'toggleterm'
local util = require('my.util')
local nmap_leader = util.nmap_leader
local open_mapping = [[<c-\>]]
local direction = 'horizontal'
-- plugin setup config options
local config = {
  size = function(term)
    if term.direction == 'horizontal' then
     return vim.o.lines * 0.6
    elseif term.direction == 'vertical' then
      return vim.o.columns * 0.5
    end
  end,
  open_mapping = open_mapping ,
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = horizontal,
  close_on_exit = false,
  auto_scroll = false,
  -- This field is only relevant if direction is set to 'float'
  autochdir = false,
  persist_size = false, -- temporarily change window position must be possible
  persist_mode = true,
  winbar = {
    enabled = true,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end
  },
}

M.setup = function()
 require(name).setup(config)
end

-- local lazygit = require("toggleterm.terminal").Terminal:new({
--   cmd = "lazygit",
--   count = 99,
--   hidden = true,
--   direction = "tab" })
-- --
-- -- vim.keymap.set(", "<leader>mt", function() vim.cmd("ToggleTermToggleAll") end, {
-- --   desc = "ToggleTerm all",
-- --   silent = true,
-- -- })

-- plugin leader mappings
-- M.mappings = function()
-- local opts = { noremap = true, silent = true }
-- nmap_leader("gg", function() lazygit:toggle() end, '[terminal] Lazygit' ,opts )
-- end

return M
