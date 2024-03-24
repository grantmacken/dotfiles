local M = {}
M.name = 'miniclue'
local miniclue = require("mini.clue")
local util = require('my.util')
local nmap_leader = util.nmap_leader

-- plugin setup config options

-- Delay before showing clue window
local delay = 1000

local window = {
    config = { width = "auto" },
    delay = delay,
    -- Keys to scroll inside the clue window
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  }


local leader_group_clues = {
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<Leader>L', desc = '+Lua' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>r', desc = '+R' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal/Minitest' },
  { mode = 'n', keys = '<Leader>T', desc = '+Test' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },

  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'x', keys = '<Leader>r', desc = '+R' },
}


-- local buffer_trigger = require('plugins.bufremove').trigger
  -- Array of opt-in triggers which start custom key query process.
  -- **Needs to have something in order to show clues**.
local triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- Built-in completion
    { mode = "i", keys = "<C-x>" },
    -- `g` key
    { mode = "n", keys = "g" },
    { mode = "x", keys = "g" },
    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },
    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },
    -- Window commands
    { mode = "n", keys = "<C-w>" },
    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  }

 -- Array of extra clues to show
 -- Enhance this by adding descriptions for <Leader> mapping groups
local clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  --{ mode = 'n', keys = '<Leader>h', desc = '+Harpoon' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  miniclue.gen_clues.builtin_completion(),
  miniclue.gen_clues.g(),
  miniclue.gen_clues.marks(),
  miniclue.gen_clues.registers(),
  miniclue.gen_clues.windows(),
  miniclue.gen_clues.z(),
}





M.config = {
  window = window,
  clues = clues,
  triggers = triggers
}

-- plugin leader mappings
M.mappings = function()
-- local nmap_leader = util.nmap_leader
-- b is for 'buffer'
-- nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
end

return M
