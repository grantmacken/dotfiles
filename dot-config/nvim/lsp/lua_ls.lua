local metaPath = vim.fn.stdpath('config') .. '/meta'
local logPath = vim.fn.stdpath('cache') .. '/lua_lang_serv.log'
local tbl_cmd = { 'lua-language-server', '--logpath', logPath, '--metapath', metaPath }

local tbl_settings = {
  --   on_attach = function(client, buf_id)
  --   -- Reduce very long list of triggers for better 'mini.completion' experience
  --   client.server_capabilities.completionProvider.triggerCharacters =
  --     { '.', ':', '#', '(' }
  --   -- Use this function to define buffer-local mappings and behavior that depend
  --   -- on attached client or only makes sense if there is language server attached.
  -- end,
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global, etc.
      globals = { 'vim', 'describe', 'it', 'before_each', 'after_each', 'setup', 'teardown', 'pending', 'assert', 'spy', 'stub', 'mock' },
      disable = { 'duplicate-set-field', 'need-check-nil' },
      -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
      workspaceDelay = -1,
    },
    -- Make the server aware of Neovim runtime files
    workspace = {
      checkThirdParty = false,
      library = { vim.env.VIMRUNTIME },
      ignoreSubmodules = true,
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
  }
}

return {
  cmd = tbl_cmd,
  filetypes = { 'lua' },
  root_markers = {
    '.git',
  },
  settings = tbl_settings,
}
