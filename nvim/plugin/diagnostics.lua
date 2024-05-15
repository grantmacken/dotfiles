--- diagnostics.lua
---
--- Diagnostics configuration
local severity = vim.diagnostic.severity
vim.diagnostic.config({
  underline = {
    severity = {
      min = severity.WARN,
    },
  },
  signs = {
    severity = {
      min = severity.WARN,
    },
  text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  virtual_text = false,
  update_in_insert = true,
  severity_sort = true,
  float = {
    source = "always",
    border = "rounded",
    show_header = false,
  },
})

 -- disable diagnostics right after going into insert mode (or select mode).

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = {'n:i', 'v:s'},
  desc = 'Disable diagnostics in insert and select mode',
  callback = function(e) vim.diagnostic.disable(e.buf) end
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = 'i:n',
  desc = 'Enable diagnostics when leaving insert mode',
  callback = function(e) vim.diagnostic.enable(e.buf) end
})


vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
