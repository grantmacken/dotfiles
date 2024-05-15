local lsp = 'markdown-language-server'
if vim.fn.executable(lsp) ~= 1 then return end
-- :h ClientConfig
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/jsonls.lua
-- https://github.com/lspcontainers/lspcontainers.nvim?tab=readme-ov-file#jsonls
-- @CITE: https://github.com/lspcontainers/lspcontainers.nvim?tab=readme-ov-file#process-id
-- required for several LSPs, and they will exit immediately if this is not specified.
local beforeInit = function(params)
  params.processId = vim.NIL
end

-- needed to enable formatting capabilities
local initOptions = { provideFormatter = true }

local settings = {}

local client_id = vim.lsp.start({
  name = lsp, --Name in log messages
  cmd = { lsp },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
  workspace_folders = nil,
  init_options = initOptions,
  before_init = beforeInit,
  settings = settings
})

-- log(  'file type: '  .. args.match )
-- log(  'file location: ' .. args.file )
vim.notify(lsp .. ' clent id: ' .. client_id)
