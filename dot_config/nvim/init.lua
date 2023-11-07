--require('disable')
vim.g.mapleader = ' '
require('my.util').clear_log()
require("mappings").setup()
require("options").setup()
require("commands").setup()
require("autocmds").setup()
require("my.lsp").setup()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup('plugins')
