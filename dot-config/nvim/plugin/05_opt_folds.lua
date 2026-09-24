--[[ Folds:
## built in keybindings
  - zM: close all folds
  - zR: open all folds
  - zA: toggle fold under cursor
  - zj: jump to next fold
  - zk: jump to previous fold
  - zc: close fold under cursor
  - zo: open fold under cursor
  - zr: reduce folding by one level (open more folds)
  - zm: increase folding by one level (close more folds)
## Docs
    https://neovim.io/doc/user/fold.html#folding
  - https://neovim.io/doc/user/options.html#'foldmethod'
  - https://neovim.io/doc/user/options.html#'foldexpr'
  - https://neovim.io/doc/user/options.html#'foldlevel'
  - https://neovim.io/doc/user/options.html#'foldnestmax'
  - https://neovim.io/doc/user/options.html#'foldtext'
  - https://neovim.io/doc/user/options.html#'foldcolumn'
  - https://neovim.io/doc/user/options.html#'foldenable'
## Notes:
  - Folds are created based on the foldmethod and foldexpr options.
  - The foldlevel option controls how many folds are open by default.
  - The foldnestmax option controls how many levels of folds can be nested.
  - The foldtext option controls what text is displayed for a closed fold.
  - The foldcolumn option controls how many columns are used to display folds.
  - The foldenable option controls whether folding is enabled or not.
]]

vim.o.foldmethod  = 'expr'
vim.o.foldexpr    = 'v:lua.vim.lsp.foldexpr()'
-- vim.o.foldexpr       = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel   = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext    = '' -- Show text under fold with its highlighting--
--
--vim.o.foldcolumn     = "0"
--vim.o.foldenable     = true


