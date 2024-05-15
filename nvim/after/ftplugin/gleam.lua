local lsp = 'gleam-language-server'
if vim.fn.executable(lsp) ~= 1 then return end
local onAttach = require('mod.lsp').on_attach
local capabilities = require('mod.lsp').capabilities
local rootDir = vim.fs.dirname(vim.fs.find({ '.git',"gleam.toml"}, { upward = true })[1])
if rootDir == nil then return end
-- :h ClientConfig
local client_id = vim.lsp.start({
  name = lsp, --Name in log messages
  cmd = {lsp},
  root_dir = rootDir,
  on_attach = onAttach,
  capabilities = capabilities,
  -- before_init = beforeInit,
  --settings = {}
  })
vim.notify(lsp .. ' clent id: ' .. client_id)
