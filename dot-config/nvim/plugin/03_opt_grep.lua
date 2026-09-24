
--[[ GREP SEARCHING
# Docs
  - https://neovim.io/doc/user/options.html#'grepprg'
  - https://neovim.io/doc/user/options.html#'grepformat'
# Notes
  - The 'grepprg' option is the program that is used to search for a pattern in files.
  - The 'grepformat' option is the format of the output of the grep program.
]]
vim.o.grepprg    = "rg --vimgrep --no-heading --smart-case --hidden --glob '!.git' --glob '!node_modules' --glob '!tmp'"
vim.o.grepformat = "%f:%l:%c:%m"
