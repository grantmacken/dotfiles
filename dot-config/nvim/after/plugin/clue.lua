local ok, miniclue = pcall(require,'mini.clue')
if not ok then return end

local leader_group_clues = {
  { mode = 'n', keys = '<Leader>a', desc = '+AiCopilotChat' },
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  { mode = 'n', keys = '<Leader>d', desc = '+Diagnostic' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>c', desc = '+Complete' },
  { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },
}

local delay = 1000
local window = {
  config = { width = "auto" },
  delay = delay,
  scroll_down = '<C-d>',
  scroll_up = '<C-u>',
}

local triggers = {
  { mode = "n", keys = "<Leader>" },
  { mode = "x", keys = "<Leader>" },
  { mode = "i", keys = "<C-x>" },
  { mode = "n", keys = "g" },
  { mode = "x", keys = "g" },
  { mode = "n", keys = "'" },
  { mode = "n", keys = "`" },
  { mode = "x", keys = "'" },
  { mode = "x", keys = "`" },
  { mode = "n", keys = '"' },
  { mode = "x", keys = '"' },
  { mode = "i", keys = "<C-r>" },
  { mode = "c", keys = "<C-r>" },
  { mode = "n", keys = "<C-w>" },
  { mode = "n", keys = "z" },
  { mode = "x", keys = "z" },
}

miniclue.setup({
  window = window,
  triggers = triggers,
  clues = {
    leader_group_clues,
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
