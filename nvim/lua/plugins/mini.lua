
local util = require('mod.util')
local nmap_leader = util.nmap_leader

require("mini.statusline").setup()
require("mini.tabline").setup()

require("mini.trailspace").setup()
require("mini.cursorword").setup()
require("mini.bufremove").setup()
require("mini.splitjoin").setup()
require("mini.comment").setup()
require("mini.surround").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
vim.notify = require('mini.notify').make_notify()

require('mini.visits').setup({})


local make_select_path = function(select_global, recency_weight)
  local visits = require('mini.visits')
  local sort = visits.gen_sort.default({ recency_weight = recency_weight })
  local select_opts = { sort = sort }
  return function()
    local cwd = select_global and '' or vim.fn.getcwd()
    visits.select_path(cwd, select_opts)
  end
  end

  local map = function(lhs, desc, ...)
    vim.keymap.set('n', lhs, make_select_path(...), { desc = desc })
  end

  -- Adjust LHS and description to your liking
  map('<Leader>vr', 'Select recent (all)',   true,  1)
  map('<Leader>vR', 'Select recent (cwd)',   false, 1)
  map('<Leader>vy', 'Select frecent (all)',  true,  0.5)
  map('<Leader>vY', 'Select frecent (cwd)',  false, 0.5)
  map('<Leader>vf', 'Select frequent (all)', true,  0)
  map('<Leader>vF', 'Select frequent (cwd)', false, 0)

  local map_vis = function(keys, call, desc)
    local rhs = '<Cmd>lua MiniVisits.' .. call .. '<CR>'
    vim.keymap.set('n', '<Leader>' .. keys, rhs, { desc = desc })
  end
  map_vis('vv', 'add_label()',          'Add label')
  map_vis('vV', 'remove_label()',       'Remove label')
  map_vis('vl', 'select_label("", "")', 'Select label (all)')
  map_vis('vL', 'select_label()',       'Select label (cwd)')

local map_branch = function(keys, action, desc)
  local rhs = function()
    local branch = vim.fn.system('git rev-parse --abbrev-ref HEAD')
    if vim.v.shell_error ~= 0 then return nil end
    branch = vim.trim(branch)
    require('mini.visits')[action](branch)
  end
  vim.keymap.set('n', '<Leader>' .. keys, rhs, { desc = desc })
end

  map_branch('vb', 'add_label',    'Add branch label')
  map_branch('vB', 'remove_label', 'Remove branch label')

nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
-- Delay before showing clue window
local clue_delay = 1000
local clue_window = {
  config = { width = "auto" },
  delay = clue_delay,
  -- Keys to scroll inside the clue window
  scroll_down = '<C-d>',
  scroll_up = '<C-u>',
}

local clue_triggers = {
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

local miniclue = require('mini.clue')
miniclue.setup({
  window = clue_window,
  triggers = clue_triggers,
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})

require("mini.completion").setup({
    source_func = 'omnifunc',
    auto_setup = false
  })



-- creates global table  MiniCompletion

--[[
-- CLUES
--]]--

-- local mappings = function()
-- -- b is for 'buffer'
--
-- end
--
--
--
--   local MiniStatusline = require("mini.statusline")
--   MiniStatusline.setup()
--
--   local MiniCompletion = require("mini.completion")
--   MiniCompletion .setup({
--     source_func = 'omnifunc',
--     auto_setup = false
--   })
--

  -- local MiniNotify = require("mini.notify")
  -- MiniNotify.setup({lsp_progress = false})
  -- local notify = MiniNotify.make_notify()
  -- vim.notify = notify
  -- MiniNotify.setup({ lsp_progress = { enable = true } })

  
 -- mappings()


