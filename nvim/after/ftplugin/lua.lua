local lsp = 'lua-language-server'
if vim.fn.executable(lsp) ~= 1 then return end
local bufnr = vim.api.nvim_get_current_buf()

local rootDir = vim.fs.root(bufnr, { '.git', '.stylua.toml' })
if rootDir == nil then return end
vim.bo[bufnr].comments = ':---,:--'
-- TODO use vim.fs.root()|

local onAttach = require('mod.lsp').on_attach
local capabilities = require('mod.lsp').capabilities
-- add or subtract capabilities
--capabilities.textDocument.completion.completionItem.snippetSupport = true



-- :h ClientConfig
local client_id = vim.lsp.start({
  name = lsp, --Name in log messages
  cmd = {lsp},
  root_dir = rootDir,
  on_attach = onAttach,
  capabilities = capabilities,
  -- before_init = beforeInit,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = { 'vim', 'describe', 'it', 'assert', 'stub' },
        disable = {'duplicate-set-field',},
      },
      workspace = {
        checkThirdParty = false,
        library = {vim.env.VIMRUNTIME,}
      },
      telemetry = {
        enable = false,
      },
      hint = { -- inlay hints
        enable = true,
      },
      codeLens = {
        enable = true,
      },
    },
  },
})
--  https://github.com/tjdevries/config.nvim/blob/master/lua/custom/plugins/lsp.lua#L141
--local client = assert(vim.lsp.get_client_by_id(client_id), 'must have client id')
-- client.server_capabilities.semanticTokensProvider = nil

vim.notify(lsp .. ' clent id: ' .. client_id)
--vim.print(client.server_capabilities)

--{"id":1,"jsonrpc":"2.0","result":{"capabilities":{
  --"codeActionProvider":{"codeActionKinds":["","quickfix","refactor.rewrite","refactor.extract"],"resolveProvider":false},
  --"codeLensProvider":{"resolveProvider":true},
  --"colorProvider":true,
  --"completionProvider":{"resolveProvider":true,"triggerCharacters":["\t","\n",".",":","(","'","\"","[",",","#","*","@","|","=","-","{"," ","+","?"]},
  --"definitionProvider":true,
  --"documentFormattingProvider":true,
  --"documentHighlightProvider":true,
  --"documentOnTypeFormattingProvider":{"firstTriggerCharacter":"\n"},
  --"documentRangeFormattingProvider":true,
  --"documentSymbolProvider":true,
  --"executeCommandProvider":{"commands":["lua.removeSpace","lua.solve","lua.jsonToLua","lua.setConfig","lua.getConfig","lua.autoRequire"]},
  --"foldingRangeProvider":true,
  --"hoverProvider":true,
  --"inlayHintProvider":{"resolveProvider":true},
  --"offsetEncoding":"utf-16",
  --"referencesProvider":true,
  --"renameProvider":{"prepareProvider":true},
  --"semanticTokensProvider":
  -- {"full":true,"legend":{
    -- "tokenModifiers":["declaration","definition","readonly","static","deprecated","abstract","async","modification",
    -- "documentation","defaultLibrary","global"],
    -- "tokenTypes":["namespace","type","class","enum","interface","struct","typeParameter","parameter","variable",
    -- "property","enumMember","event","function","method","macro","keyword","modifier","comment","string","number",
    -- "regexp","operator","decorator"]},
    -- "range":true},
    --"signatureHelpProvider":{"triggerCharacters":["(",","]},
    --"textDocumentSync":{"change":2,"openClose":true,"save":{"includeText":false}},
    --"typeDefinitionProvider":true,
    --"workspace":{"fileOperations":{"didRename":{"filters":[]}},
    --"workspaceFolders":{"changeNotifications":true,"supported":true}},
    --"workspaceSymbolProvider":true},
    --"serverInfo":{"name":"sumneko.lua"}}}
    -- ontent-Length: 120
