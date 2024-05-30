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
--
--
local lspMappings = function(bufnr)
local keymap = vim.keymap

local function desc( description) return { noremap = true, silent = true, buffer = bufnr, desc = description } end
-- Keywords LSP as keywordprg
-- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.
-- keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, desc('lsp: signature help'))
-- GOTOs Declaration Definition Implementation References
--  gr
--  gd  default keymap.set('n', 'gd', vim.lsp.buf.definition, desc('lsp: go to [d]efinition'))
keymap.set('n', 'gD', vim.lsp.buf.declaration, desc('lsp: go to [D]eclaration'))
keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('LSP: go to [i]mplementation'))
-- GOTO References
-- "gr" is mapped in Normal mode to vim.lsp.buf.references() gr-default
-- GOTO Definitions as tagfunc
-- "gd" is mapped to vim.lsp.buf.definition
-- -- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like go-to-definition, |:tjump|, 
-- and keymaps like |CTRL-]|, |CTRL-W_]|,|CTRL-W_}| to utilize the language server
-- keymap.set('n', 'gr', vim.lsp.buf.references, desc('lsp: [g]et [r]eferences'))
-- keymap.set('n', '<leader>gi', go_to_first_import, desc('lsp: [g]o to fist [i]mport'))
-- Signature Help
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()

-- Workspace Folders
keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, desc('LSP: [w]orkspace folder [a]dd'))
keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, desc('LSP: [w]orkspace folder [r]emove'))
keymap.set('n', '<leader>wl', function() vim.print(vim.lsp.buf.list_workspace_folders()) end, desc('lsp: [w]orkspace folders [l]'))
keymap.set('n', '<leader>wq', vim.lsp.buf.workspace_symbol, desc('LSP: [w]orkspace symbol [q]uery'))

keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, desc('LSP: [w]orkspace [s]ymbol'))
keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, desc('lsp: [d]ocument [s]ymbol'))
-- Code Actions and Code Code Rename
-- "crn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "crr" is mapped in Normal mode to vim.lsp.buf.code_action()
-- CTRL-R CTRL-R (also "CTRL-R r") is mapped in Visual mode to vim.lsp.buf.code_action()
-- Code Lens
-- TODO
-- Code Formating
-- 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via |gq| if the language server supports it.
-- To opt out of this use |gw| instead of gq, or set 'formatexpr' on LspAttach.
--
--
end

M.on_attach = function(client, bufnr)
  --local client = vim.lsp.get_client_by_id(args.data.client_id)
  --local bufnr = args.buf
  -- Enable omnifunc-completion
  --    local log = require('my.logger').log
 vim.cmd.setlocal('signcolumn=yes')
 vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  -- log('Lang Server attached buffer: ' .. bufnr)
  vim.cmd.setlocal('signcolumn=yes')
  local function buf_set_var(...)
    vim.api.nvim_buf_set_var(bufnr, ...)  
  end
  vim.bo[bufnr].bufhidden = 'hide'
  buf_set_var('lsp_client_id', client.id)
  lspMappings(bufnr)

end

-- https://github.com/mrcjkb/nvim/blob/master/lib/lua/mrcjk/lsp/init.lua
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp_lsp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if has_cmp_lsp then
  capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
else
  -- The vs code extracted containers require this
  -- TODO add this to after/ftplugin
  capabilities.textDocument.completion.completionItem.snippetSupport = true
end

--TODO
M.capabilities = capabilities





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




return M
