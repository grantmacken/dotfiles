---
description: Convert old Vimscript to modern Neovim Lua
---
Convert the provided Vimscript configuration to idiomatic Neovim Lua using the latest Neovim API.

Requirements:
- Use `vim.keymap.set` for keybindings.
- Use `vim.opt`, `vim.o`, `vim.g`, `vim.wo`, or `vim.bo` for options and variables.
- Use `vim.api.nvim_create_autocmd` and `vim.api.nvim_create_augroup` for autocommands.
- Use `vim.api.nvim_create_user_command` for custom commands.
- Provide only the raw Lua code in your response without markdown formatting (no ```lua blocks) so the output can be safely redirected or piped into a file.
