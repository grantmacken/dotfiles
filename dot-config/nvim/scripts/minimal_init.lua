-- Minimal init for MiniTest child Neovim processes.
-- Keep the project config out of the child, but make its Lua modules available.

local source = debug.getinfo(1, 'S').source:sub(2)
local config_root = vim.fn.fnamemodify(source, ':h:h')
local lua_root = vim.fs.joinpath(config_root, 'lua')

-- Add the Neovim configuration and its Lua directory to the child runtime.
local runtimepath = vim.o.runtimepath .. ',' .. config_root
vim.api.nvim_set_option_value('runtimepath', runtimepath, {})
package.path = table.concat({
  vim.fs.joinpath(lua_root, '?.lua'),
  vim.fs.joinpath(lua_root, '?/init.lua'),
  package.path,
}, ';')

-- Make screenshot tests less sensitive to the parent configuration.
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  command = 'setlocal foldmethod=manual',
})
vim.api.nvim_set_option_value('termguicolors', true, {})
