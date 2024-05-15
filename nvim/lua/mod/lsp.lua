local M = {}
-- - 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
--   completion.
--
-- - 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like go-to-definition, |:tjump|, 
--   and keymaps like |CTRL-]|, |CTRL-W_]|,|CTRL-W_}| to utilize the language server.
--
-- - 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via |gq| if the language server supports it.
--   - To opt out of this use |gw| instead of gq, or set 'formatexpr' on LspAttach.
--
-- - |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or
--   a custom keymap for `K` exists.
--
-- *crr* *v_crr* *crn* *i_CTRL-S* *v_CTRL-R_CTRL-R* *v_CTRL-R_r*
-- Some keymaps are created unconditionally when Nvim starts:
-- - "crn" is mapped in Normal mode to vim.lsp.buf.rename()
-- - "crr" is mapped in Normal mode to vim.lsp.buf.code_action()
-- - CTRL-R CTRL-R (also "CTRL-R r") is mapped in Visual mode to vim.lsp.buf.code_action()
-- - "gr" is mapped in Normal mode to  vim.lsp.buf.references() gr-default
-- - CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

M.on_attach = function(client, bufnr)
  --local client = vim.lsp.get_client_by_id(args.data.client_id)
  --local bufnr = args.buf
  -- Enable omnifunc-completion
  --    local log = require('my.logger').log
 vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  -- log('Lang Server attached buffer: ' .. bufnr)
end


local capabilities = vim.lsp.protocol.make_client_capabilities()

local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp_lsp then
  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
else
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

-- capabilities = require('lsp-selection-range').update_capabilities(capabilities)
-- Enable preliminary support for workspace/didChangeWatchedFiles
-- capabilities = vim.tbl_deep_extend('keep', capabilities, {
--   workspace = {
--     didChangeWatchedFiles = {
--       dynamicRegistration = true,
--     },
--   },}

-- foldingRange capabilities provided by the nvim-ufo plugin
-- - @diagnostic disable-next-line: inject-field
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }


M.capabilities = capabilities


return M
