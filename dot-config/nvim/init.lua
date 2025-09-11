-- Initialization =============================================================
pcall(function()
  vim.loader.enable()
  -- vim.deprecate = function() end
end)
-- disable built-in providers
local providers = { "perl", "ruby", "python", "python3" }
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- disable built-in plugins
local plugins = { 'gzip', 'netrwPlugin', 'rplugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin', }
for _, plugin in ipairs(plugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = vim.keycode("<space>") -- Set leader key to space

local keymap = require('util').keymap
keymap('<Leader>t', ':botright sp | term<CR>', 'Open [t]erminal')
keymap('<esc>',[[<C-\><C-n>]], 'Close [t]erminal','t')
keymap('<Leader>r', ':restart<CR>', '[r]estart nvim')
keymap('<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', 'set [q]uickfix list')


local group = vim.api.nvim_create_augroup('my_group', {})
local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = group, pattern = pattern, callback = callback, desc = desc })
end

--- Highlight on yank
au('TextYankPost', '*',function() vim.hl.on_yank() end,'Highlight yanked text')

local start_terminal_insert = vim.schedule_wrap(function(data)
  -- Try to start terminal mode only if target terminal is current
  if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then return end
  vim.cmd('startinsert')
end)
au('TermOpen', 'term://*', start_terminal_insert, 'Start builtin terminal in Insert mode')
