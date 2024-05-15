local lsp = 'html-language-server'
if vim.fn.executable(lsp) ~= 1 then return end
-- :h ClientConfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/bashls.lua
-- https://github.com/lspcontainers/lspcontainers.nvim?tab=readme-ov-file#yamlls
--
-- @CITE: https://github.com/lspcontainers/lspcontainers.nvim?tab=readme-ov-file#process-id
--Process Id-
-- The LSP spec allows a client to send its process id to a language server, so that the server can exit immediately
-- when it detects that the client is no longer running.
-- This feature fails to work properly no a containerized language server because the host and the container do not
-- share the container namespace by default.
-- A container can share a process namespace with the host by passing the --pid=host flag to docker/podman, although
-- it should be noted that this somewhat reduces isolation.
-- It is also possible to simply disable the process id detection. This can be done with the
-- following before_init function:
-- This is required for several LSPs, and they will exit immediately if this is not specified.

local beforeInit = function(params)
  params.processId = vim.NIL
end

-- needed to enable formatting capabilities
local initOptions = {
  provideFormatter = true,
  embeddedLanguages = { css = true, javascript = true },
  configurationSection = { 'html', 'css', 'javascript' },
}

local settings = {}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local client_id = vim.lsp.start({
  name = lsp, --Name in log messages
  cmd = { lsp },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
  workspace_folders = nil,
  capabilities = capabilities,
  init_options = initOptions,
  before_init = beforeInit,
  settings = settings
})

-- log(  'file type: '  .. args.match )
-- log(  'file location: ' .. args.file )
vim.notify(lsp .. ' clent id: ' .. client_id)
