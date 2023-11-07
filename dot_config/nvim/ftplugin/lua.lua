local log = require('my.util').log
log('filetype: lua')
      -- workspace_folders = nil,
      -- before_init(initialize_params, config) 
      -- on_init(client, initialize_result)
      -- on_exit(code, signal, client_id)
      -- on_attach (client, bufnr )
      -- handlers = {}
      -- get_language_id
      -- offset_encoding
      -- on_error

    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    local root_dir = vim.fs.dirname(vim.fs.find({ 'Makefile', '.git', 'init.lua'  }, { upward = true })[1])
     local onInit = function(client, _)
    log( 'client' .. client )
    end
    vim.lsp.start({
      name = 'lua_ls',
      cmd = { 'lua-language-server' },
      root_dir = root_dir,
      on_init = onInit,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = runtime_path,
          },
          diagnostics = { globals = { "vim" }},
          workspace = {library = vim.api.nvim_get_runtime_file("", true)},
          telemetry = {enable = false},
        }}
      })

    -- vim.lsp.buf_attach_client(0, client)
