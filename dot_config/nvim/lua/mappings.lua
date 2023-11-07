local M = {}
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local log = require('my.util').log
M.setup = function()
  vim.cmd [[ command! W  execute ':w' ]] -- map :W to :w (helps which-key issue)
  local km = vim.keymap.set
  km('n', ' ', '<Nop>', { silent = true, remap = false })
  km('n', '<leader>cm', '<cmd>Mason<cr>', { desc = 'Mason' })
  km('n', '<F10>', '<cmd>:TSNodeUnderCursor<cr>', { desc = 'TS node under curser' })
  km('n', '<F11>', '<cmd>TSHighlightCapturesUnderCursor<cr>', { desc = 'TS captures under curser' })
  km('n', '<F12>', '<cmd>TSPlaygroundToggle<cr>', { desc = 'TS playground' })
  km('n', '<F9>', '<cmd>write | edit | TSBufEnable highlight<cr>', { desc = 'Reload Highlights' })

  -- Move to window using the <ctrl> hjkl keys
  km('n', '<C-Left>', '<C-w>h', { desc = 'Go to left window' })
  km('n', '<C-Down>', '<C-w>j', { desc = 'Go to lower window' })
  km('n', '<C-Up>', '<C-w>k', { desc = 'Go to upper window' })
  km('n', '<C-Right>', '<C-w>l', { desc = 'Go to right window' })
  -- Move Lines
  km('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
  km('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
  km('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
  km('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
  km('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
  km('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

  -- Navigate tabs
  km('n', ']t', function() vim.cmd.tabnext() end, { desc = 'Next tab' })
  km('n', '[t', function()
    vim.cmd.tabprevious()
  end, { desc = 'Previous tab' })

  km('n', '<F5>', vim.diagnostic.open_float, { desc = 'Next tab' })
  km('n', '[d', vim.diagnostic.goto_prev, { desc = 'Next tab' })
  km('n', ']d', vim.diagnostic.goto_next, { desc = 'Previous tab' })

  log('vim mappings setup')
end

return M
