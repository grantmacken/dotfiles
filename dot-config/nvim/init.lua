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


