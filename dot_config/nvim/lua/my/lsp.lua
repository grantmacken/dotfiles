local M = {}
local log = require('my.util').log

local signs = function()
  -- See :help sign_define()
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({ name = 'DiagnosticSignError', text = '✘' })
  sign({ name = 'DiagnosticSignWarn', text = '▲' })
  sign({ name = 'DiagnosticSignHint', text = '⚑' })
  sign({ name = 'DiagnosticSignInfo', text = '»' })
end

local diagnostics = function()
  -- See :help vim.diagnostic.config()
  vim.diagnostic.config({
    virtual_text = false,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
    },
  })
end


local handlers = function()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )
end

M.setup = function()
  signs()
  diagnostics()
  handlers()
  log('my lsp setup completed')
end

return M

-- @textDocument/definition
-- vim.lsp.handlers["textDocument/definition"] = function(_, result)
--   if not result or vim.tbl_isempty(result) then
--     print "[LSP] Could not find definition"
--     return
--   end
--
--   if vim.tbl_islist(result) then
--     vim.lsp.util.jump_to_location(result[1], "utf-8")
--   else
--     vim.lsp.util.jump_to_location(result, "utf-8")
--   end
-- end
--
-- -- @textDocument/definition
-- vim.lsp.handlers["textDocument/publishDiagnostics"] =
--   vim.lsp.with(vim.lsp.handlers.on_publish_diagnostics, {
--     signs = {
--       severity_limit = "Error",
--     },
--     underline = {
--       severity_limit = "Warning",
--     },
--     virtual_text = true,
--   })

--   vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
--   vim.lsp.handlers.hover ,
--   {border = 'rounded'}
-- )
-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
--   vim.lsp.handlers.signature_help,
--   {border = 'rounded'}
-- )
-- vim.notify( 'lsp handlers')
