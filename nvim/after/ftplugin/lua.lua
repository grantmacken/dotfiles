local conf = {
  name = 'lua_ls', --Name in log messages
  cmd = { 'lua-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find({'.git'}, { upward = true })[1]),
  workspace_folders = nil,
  -- before_init = beforeInit,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = {
          'MiniCompletion',
          'MiniDeps',
          'MiniExtra',
          'MiniMisc',
          'MiniNotify',
          'MiniPick',
          'vim',
        },
        disable = {
          'duplicate-set-field',
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
        },
      },
      telemetry = {
        enable = false,
      },
      hint = { -- inlay hints
        enable = true,
      },
    },
  },
}

-- log(  'file type: '  .. args.match )
-- log(  'file location: ' .. args.file )
local client_id = vim.lsp.start(conf)
vim.notify(  'clent id: ' .. client_id )


