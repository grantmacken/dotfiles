local root_dir
for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
  if vim.fn.isdirectory(dir .. "/.git") == 1 then
  root_dir = dir
  break
  end
end

if not root_dir then return end
-- vim.notify( 'ftplugin activated: ' .. root_dir )
-- vim.uv.os_homedir()
-- vim.notify( vim.uv.os_homedir() .. '.local/bin/lua-language-server')
local lspCmd = vim.fn.expand('$HOME/.local/bin/lua-language-server')
local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
-- :h ClientConfig
local client_id = vim.lsp.start({
  name = 'luals', --Name in log messages
  cmd = {lspCmd},
  root_dir = { vim.fs.root(0, '.git') },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_var(bufnr, 'lsp_client_id', client.id)
    vim.cmd.setlocal('signcolumn=yes')
    --vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
    vim.notify( [[ - lua-language-server attached ]] )
  end,
  capabilities = lspCapabilities,
  -- before_init = beforeInit,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = { 'vim', 'describe', 'it', 'assert', 'stub', 'before_each', 'after_each'},
        disable = {'duplicate-set-field','need-check-nil' },
        -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
        workspaceDelay = -1,
      },
      workspace = {
        checkThirdParty = false,
        library = {vim.env.VIMRUNTIME,},
         -- Don't analyze code from submodules
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
    },
  },
})

-- local ok

--[[
SNIPPETS
TODO
h vim.snippet
]] --

-- vim.snippet.add(
--   "fn",
--   "function ${1:name}($2)\n\t${3:-- content}\nend",
--   { buffer = 0 }
-- )
-- vim.snippet.add(
--   "lfn",
--   "local function ${1:name}($2)\n\t${3:-- content}\nend",
--   { buffer = 0 }
-- )

--[[
--FOLDS
-- based on treesitter
--TODO
--]]
-- vim.notify( 'ftplugin activated: ' .. root_dir )
-- vim.uv.os_homedir()
-- vim.notify( vim.uv.os_homedir() .. '.local/bin/lua-language-server')
--local lspCapabilities = vim.lsp.protocol.make_client_capabilities()
-- :h ClientConfig
-- Create a new LSP client and start a language server or reuses an already
-- running client if one is found matching `name` and `root_dir`. Attaches
-- the current buffer to the client.
-- Starts and initializes a client with the given configuration
--[[
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global, etc.
        globals = { 'vim', 'describe', 'it', 'assert', 'stub', 'before_each', 'after_each' },
        disable = { 'need-check-nil' },
        -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
        workspaceDelay = -1,
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME, },
        -- Don't analyze code from submodules
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
    },
  },

]]--
--[[
vim.lsp.start({
  name = 'lua_ls', --Name in log messages
  cmd = { vim.uv.os_homedir() .. '.local/bin/lua-language-server' },
  root_dir = { vim.fs.root(0, '.git') }
})
]]--
