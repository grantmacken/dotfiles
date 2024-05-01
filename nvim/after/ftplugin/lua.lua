local lsp = 'lua-language-server'
if vim.fn.executable(lsp) ~= 1 then return end
local onAttach = require('mod.lsp').on_attach
local capabilities = require('mod.lsp').capabilities
local rootDir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
if rootDir == nil then return end
-- :h ClientConfig
local client_id = vim.lsp.start({
  name = lsp, --Name in log messages
  cmd = {lsp},
  root_dir = rootDir,
  workspace_folders = nil,
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
        globals = {
          'vim',
        },
        disable = {
          'duplicate-set-field',
        },
      },
      workspace = {
        checkThirdParty = false,
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
vim.notify(lsp .. ' clent id: ' .. client_id)

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
