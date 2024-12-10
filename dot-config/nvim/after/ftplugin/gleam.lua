if vim.fn.executable('gleam') ~= 1 then return end
local root_dir = vim.fs.dirname(vim.fs.find({'gleam.toml' }, { upward = true })[1])
if root_dir == nil then return end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- :h ClientConfig
local client_id = vim.lsp.start({
  name = 'lua_ls', --Name in log messages
  cmd = {'gleam', lsp},
  root_dir = root_dir,
  on_attach = function(client, bufnr)
    -- generic on_attach
    require('mod.lsp').on_attach(client, bufnr)
    -- specific on attachs for this lsp - `MiniCompletion` experience
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
    vim.notify( ' - started gleam lsp' )
  end,
  capabilities = capabilities,
  -- before_init = beforeInit,
  -- settings = {},
})

