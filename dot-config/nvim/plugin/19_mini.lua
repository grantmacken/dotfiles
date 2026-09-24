local ok, mini_icons, mini_completion, mini_snippets, mini_clue, mini_keymap, mini_test

ok, mini_test = pcall(require, 'mini.test')
if not ok then
  vim.notify('Failed to load mini.test', vim.log.levels.ERROR)
  return
end
mini_test.setup({
  -- Options for collection of test cases. See `:h MiniTest.collect()`.
  collect = {
    -- Temporarily emulate functions from 'busted' testing framework
    -- (`describe`, `it`, `before_each`, `after_each`, and more)
    emulate_busted = true,
    -- Function returning array of file paths to be collected.
    -- Default: all Lua files in 'tests' directory starting with 'test_'.
    find_files = function()
      local test_dir = vim.fs.joinpath(vim.fn.stdpath('config'), 'tests')
      return vim.fn.globpath(test_dir, '**/test_*.lua', true, true)
    end,
    -- Predicate function indicating if test case should be executed
    filter_cases = function(case) return true end,
  },
  -- Options for execution of test cases. See `:h MiniTest.execute()`.
  execute = {
    -- Table with callable fields `start()`, `update()`, and `finish()`
    reporter = nil,
    -- Whether to stop execution after first error
    stop_on_error = false,
  },
  -- Path (relative to current directory) to script which handles project
  -- specific test running
  script_path = 'scripts/minitest.lua',
  -- Whether to disable showing non-error feedback
  silent = false,
}
)

ok, mini_icons = pcall(require, 'mini.icons')

if not ok then
  vim.notify('Failed to load mini.icons', vim.log.levels.ERROR)
  return
end
mini_icons.tweak_lsp_kind()

ok, mini_keymap = pcall(require, 'mini.keymap')
if not ok then
  vim.notify('Failed to load mini.snippets', vim.log.levels.ERROR)
  return
end
-- mini_keymap.setup()
-- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
mini_keymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
mini_keymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })


ok, mini_completion = pcall(require, 'mini.completion')
if not ok then
  vim.notify('Failed to load mini.completion', vim.log.levels.ERROR)
  return
end
-- Customize post-processing of LSP responses for a better user experience.
-- Don't show 'Text' suggestions (usually noisy) and show snippets last.
local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
local process_items = function(items, base)
  return mini_completion.default_process_items(items, base, process_items_opts)
end

mini_completion.setup({
  lsp_completion = {
    -- Without this config autocompletion is set up through `:h 'completefunc'`.
    -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
    -- (sets up only when needed) and makes it possible to use `<C-u>`.
    source_func = 'omnifunc',
    auto_setup = false,
    process_items = process_items,
  },
})

vim.lsp.config('*', { capabilities = mini_completion.get_lsp_capabilities() })


ok, mini_snippets = pcall(require, 'mini.snippets')
if not ok then
  vim.notify('Failed to load mini.snippets', vim.log.levels.ERROR)
  return
end
mini_snippets.setup()

ok, mini_clue = pcall(require, 'mini.clue')
if not ok then
  vim.notify('Failed to load mini.clue', vim.log.levels.ERROR)
  return
end

local leader_group_clues = {
  -- { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  -- { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  -- { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  -- { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  -- { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  -- { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  -- { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  -- { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  -- { mode = 'n', keys = '<Leader>t', desc = '+Terminal' },
  -- { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
  --
  -- { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  -- { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}


mini_clue.setup({
  triggers = {
    { mode = { "n", "x" }, keys = "<Leader>" },
    --{ mode = 'n',          keys = '\\' },       -- mini.basics
    { mode = { 'n', 'x' }, keys = '[' },     -- mini.bracketed
    { mode = { 'n', 'x' }, keys = ']' },
    { mode = 'i',          keys = '<C-x>' }, -- Built-in completion
    { mode = { 'n', 'x' }, keys = 'g' },     -- `g` key
    { mode = { 'n', 'x' }, keys = "'" },     -- Marks
    { mode = { 'n', 'x' }, keys = '`' },
    { mode = { 'n', 'x' }, keys = '"' },     -- Registers
    { mode = { 'i', 'c' }, keys = '<C-r>' },
    -- { mode = 'n',          keys = '<C-w>' },    -- Window commands
    --{ mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
    { mode = { 'n', 'x' }, keys = 'z' }, -- `z` key
  },
  clues = {
    mini_clue.gen_clues.square_brackets(),
    mini_clue.gen_clues.builtin_completion(),
    mini_clue.gen_clues.g(),
    mini_clue.gen_clues.marks(),
    mini_clue.gen_clues.registers(),
    -- mini_clue.gen_clues.windows(),
    mini_clue.gen_clues.z(),
  },
  window = {
    config = {},
    delay = 150,
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
})
