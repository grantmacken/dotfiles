local autocmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("my_" .. name, { clear = true })
end

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
  end,
})

--[[
====== FILETYPE EVENTS ======
--]]

autocmd("FileType", {
  desc = 'Enable built-in tree-sitter parsers',
  group = augroup("ts_built_in"),
  pattern = { "c", "lua", "vim", "help" },
  callback = function(args)
    if args.match == "help" then
      args.match = "vimdoc"
    end
    vim.treesitter.start(args.buf, args.match)
  end,
})


autocmd("FileType", {
  desc = 'Close specific filetype buffers with q',
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query", -- :InspectTree
    "oil",
    "oil_preview",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

autocmd("FileType", {
  desc = "With markdown and git commit turn on text wrap and spell",
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

autocmd("FileType", {
  group = augroup("unlist_quickfix"),
  desc = "Unlist quickfix buffers",
  pattern = "qf",
  callback = function() vim.opt_local.buflisted = false end,
})


--[[
====== BUFFER EVENTS ======
--]]

autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})


autocmd({ "InsertLeave", "FocusLost" }, {
  desc = 'Save when leaving buffer',
  group = augroup("autosave"),
  pattern = "<buffer>",
  command = "silent! write",
})

-- autocmd("BufWritePost", {
--   pattern = "rocks.toml",
--   command = "Rocks sync",
-- })

--[[
====== LSP ATTACH EVENT ======
  This function gets run when an LSP attaches to a particular buffer.
  That is to say, every time a new file is opened that is associated with
  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  function will be executed to configure the current buffer

LSP builtins

- 'omnifunc' is set to |vim.lsp.omnifunc()|, use |i_CTRL-X_CTRL-O| to trigger
  completion.
- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
  go-to-definition, |:tjump|, and keymaps like |CTRL-]|, |CTRL-W_]|,
  |CTRL-W_}| to utilize the language server.
- 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via
  |gq| if the language server supports it.
  - To opt out of this use |gw| instead of gq, or set 'formatexpr' on LspAttach.
- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or
  a custom keymap for `K` exists.
--]]
--
--https://vonheikemen.github.io/devlog/tools/neovim-lsp-client-guide/

local function highlight_symbol(event)
  local id = vim.tbl_get(event, 'data', 'client_id')
  local client = id and vim.lsp.get_client_by_id(id)
  if client == nil or not client.supports_method('textDocument/documentHighlight') then
    return
  end

end

autocmd({ 'LspAttach' }, {
  desc = 'Setup highlight symbol',
  group = augroup("lsp_attach"),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local capabilities = client.server_capabilities
    --inlay hints
    if client.supports_method('textDocument/inlayHint') then
      -- warning: this api is not stable yet
      -- vim.lsp.i 
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end

    -- highlight symbol
    if client.supports_method('textDocument/documentHighlight') then
      local group = augroup('highlight_symbol', {clear = false})

      vim.api.nvim_clear_autocmds({buffer = bufnr, group = group})

      vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

  end
})
-- function(args)
  --     local client = vim.lsp.get_client_by_id(args.data.client_id)
  --     local bufnr = args.buf
  --     local setBufOpts = function(description)
    --       return { noremap = true, silent = true, buffer = bufnr }
    --     end
    --     local capabilities = client.server_capabilities
    --     --diagnosticProvider
    --     -- documentFormattingProvider
    --     -- documentHighlightProvider
    --     -- documentRangeFormattingProvider
    --     -- hoverProvider
--
--
--     if capabilities.completionProvider then
--       vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
--       --vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true, buffer = bufnr })
--       --vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, buffer = bufnr })
--     end
--
--     if capabilities.typeDefinitionProvider then
--       vim.keymap.set("n", "go", vim.lsp.buf.definition, setBufOpts('Definition'))
--     end
--
--     if capabilities.renameProvider then
--       vim.keymap.set({ "n" }, "<F2>", vim.lsp.buf.rename, setBufOpts('Rename'))
--     end
--     if capabilities.documentFormattingProvider then
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = vim.api.nvim_create_augroup("LspFormat", { clear = true }),
--         buffer = bufnr,
--         callback = function()
--           vim.lsp.buf.format({ async = true })
--         end
--       })
--       -- gq| if the language server supports it
--       -- vim.keymap.set("n", "<F3>", vim.lsp.buf.format, setBufOpts('Format'))
--     end
--
--     if capabilities.codeActionProvider then
--       vim.keymap.set({ "n" }, "<F4>", vim.lsp.buf.code_action, setBufOpts('Code Actions'))
--     end
--   end

-- https://neovim.io/doc/user/diagnostic.html#diagnostic-events
autocmd('DiagnosticChanged', {
  desc = 'On diagnostic change populate locallist',
  group = augroup("diag"),
  callback = function(args)
    -- local log = require('my.logger').log
    local bufnr = args.buf
    local diagnostics = args.data.diagnostics
    local function is_open() return vim.fn.getloclist(bufnr, { winid = 0 }).winid ~= 0 end
    local opts = {
      open = false,
      severity = { min = vim.diagnostic.severity.WARN }
    }
    vim.diagnostic.setloclist(opts)
    --vim.diagnostic.setqflist(opts)
    -- log(vim.print(diagnostics))
  end,
})
