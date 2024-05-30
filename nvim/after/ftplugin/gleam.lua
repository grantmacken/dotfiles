--local lsp = 'gleam-language-server'
-- if vim.fn.executable('gleam') ~= 1 then return end
vim.treesitter.start()
local rootDir = vim.fs.root(0, { '.git', "gleam.toml" })
if rootDir == nil then return end
local onAttach = require('mod.lsp').on_attach
local capabilities = require('mod.lsp').capabilities
-- :h ClientConfig
local client_id = vim.lsp.start({
  name = 'gleamls', --Name in log messages
  cmd = {'gleam', 'lsp'},
  root_dir = rootDir,
  on_attach = onAttach,
  capabilities = capabilities,
  -- before_init = beforeInit,
  --settings = {}
  })

vim.notify('gleamls client id: ' .. client_id)
