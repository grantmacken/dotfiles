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

vim.pack.add({
 'https://github.com/echasnovski/mini.nvim',
 'https://github.com/hiphish/rainbow-delimiters.nvim',
 'https://github.com/ibhagwan/fzf-lua',
 'https://github.com/lewis6991/gitsigns.nvim',
 'https://github.com/mason-org/mason.nvim',
 'https://github.com/neanias/everforest-nvim',
 'https://github.com/stevearc/oil.nvim',
 'https://github.com/stevearc/resession.nvim',
   })

vim.cmd([[colorscheme everforest]])
local home =  vim.uv.os_homedir()
local mason_install = home .. "/.local"
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  },
  install_root_dir = mason_install,
  PATH = "skip",
})


-- vim.loader.reset()
