local keymap = require('util').keymap
local keymap_buf = require('util').keymap.keymap_buf
local keymap_dynamic = require('util').keymap_dynamic

vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'Search' })
vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'Search' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'Search' })

vim.api.nvim_set_hl(0, 'ComplMatchIns', {})
vim.api.nvim_set_hl(0, 'PmenuMatch', { link = 'Pmenu' })
vim.api.nvim_set_hl(0, 'PmenuMatchSel', { link = 'PmenuSel' })


-- Suppress "Request was superseded by a new request" messages from LSP
vim.lsp.handlers['window/showMessage'] = function(err, method, params, client_id)
  if params.message:find("Request was superseded by a new request") then
    return
  end
  vim.lsp.handlers['window/showMessage'](err, method, params, client_id)
end

-- Enable inline completion if supported by the LSP server
local support_inline_completion = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlinecompletion) then
    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
    vim.lsp.inline_completion.enable(true)
    keymap_dynamic(
      '<Tab>',
      function()
        if not vim.lsp.inline_completion.get()
        then
          return "<Tab>"
        end
      end,
      "Apply suggestion",
      bufnr
      'i')

    keymap(
      "<M-n>",
      function()
        vim.lsp.inline_completion.select({})
      end,
      "Show next inline completion suggestion",
      "i")
    keymap(
      "<M-p>",
      function()
        vim.lsp.inline_completion.select({ count = -1 })
      end,
      "Show previous inline completion suggestion",
      "i")
  end
end

-- Enable completion if supported by the LSP server
local support_completion = function(client, bufnr)
  if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
    vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    buf_keymap('<C-Space>', vim.lsp.completion.get, "Trigger lsp completion", bufnr)
  end
end

-- enable formatting on save if supported by the LSP server
local enable_format_on_save = function(client, bufnr)
  if client.supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
      desc = 'Format on save',
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Attach',
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    local bufnr = event.buf
    support_completion(client, bufnr)
    support_inline_completion(client, bufnr)
    -- Enable formatting on save
    enable_format_on_save(client, bufnr)
  end
})

vim.api.nvim_create_autocmd('LspDetach', {
  desc = 'LSP Detaching',
  group = vim.api.nvim_create_augroup("UserLspDetach", { clear = true }),
  callback = function(event)
    local bufnr = event.buf
    local client_id = event.data.client_id
    -- Get the detaching client
    local client = vim.lsp.get_client_by_id(client_id)
    -- Remove the autocommand to format the buffer on save, if it exists
    if client:supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        buffer = bufnr,
      })
    end
  end,
})

vim.api.nvim_create_user_command("LspLog", function()
  vim.cmd.edit(vim.lsp.log.get_filename())
end, {})

vim.api.nvim_create_user_command("LspHandlers", function()
  require('scratch').show(vim.tbl_keys(vim.lsp.handlers), 'LSP Handlers')
end, {})

vim.api.nvim_create_user_command("LspNames", function()
  local show = require('scratch').show
  local curBuf = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = curBuf })
  local client_names = vim.tbl_map(function(client) return client.name end, clients)
  show(client_names, 'LSP Names')
end, {})

vim.api.nvim_create_user_command("LspServerCapabilities", function()
  local show = require('scratch').show
  local curBuf = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_clients({ bufnr = curBuf })[1]
  local capabilities = client.server_capabilities
  --vim.print(vim.tbl_keys(client))
  --vim.notify(client.name)
  show(vim.inspect(capabilities), 'LSP Server Capabilities')
end, {})
