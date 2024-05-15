local M = {}
--local name = 'mini'
--local util = require('my.util')
--local nmap_leader = util.nmap_leader
--
-- local filterout_lua_diagnosing = function(notif_arr)
--   local not_diagnosing = function(notif) return not vim.startswith(notif.msg, 'lua_ls: Diagnosing') end
--   notif_arr = vim.tbl_filter(not_diagnosing, notif_arr)
--   return MiniNotify.default_sort(notif_arr)
-- end

local mappings = function()
-- b is for 'buffer'
   nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')

end

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

M.setup = function()

  local MiniStatusline = require("mini.statusline")
  MiniStatusline.setup()

  local MiniCompletion = require("mini.completion")
  MiniCompletion .setup({
    source_func = 'omnifunc',
    auto_setup = false
  })

  require("mini.trailspace").setup()
  require("mini.cursorword").setup()
  require("mini.bufremove").setup()
  require("mini.splitjoin").setup()
  require("mini.comment").setup()
  require("mini.surround").setup()
  require("mini.indentscope").setup()
  -- local MiniNotify = require("mini.notify")
  -- MiniNotify.setup({lsp_progress = false})
  -- local notify = MiniNotify.make_notify()
  -- vim.notify = notify
  -- MiniNotify.setup({ lsp_progress = { enable = true } })

  -- require("mini.notify").setup({
  --   content = { sort = filterout_lua_diagnosing },
  --   window = { config = { border = 'double' }},
  -- })
  -- local miniclue = require("mini.clue")
  -- miniclue.setup({
  --   window = clue_window,
  --   triggers = clue_triggers,
  --   clues = {
  --     { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  --     --{ mode = 'n', keys = '<Leader>h', desc = '+Harpoon' },
  --     { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  --     { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  --     { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
  --     miniclue.gen_clues.builtin_completion(),
  --     miniclue.gen_clues.g(),
  --     miniclue.gen_clues.marks(),
  --     miniclue.gen_clues.registers(),
  --     miniclue.gen_clues.windows(),
  --     miniclue.gen_clues.z(),
  --   }
  -- })
 -- mappings()
end


return M
