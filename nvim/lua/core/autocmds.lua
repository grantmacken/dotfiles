
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
--]]
--
autocmd({ 'LspAttach'}, {
  desc = 'On attaching to LSP server',
  group = augroup("lsp_attach"),
  callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf
      -- local setBufOpts = function(description)
      --       return { noremap = true, silent = true, buffer = bufnr }
      --     end
      local capabilities = client.server_capabilities
      if capabilities.completionProvider then
        vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
        -- vim.keymap.set('i', '<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   { expr = true, buffer = bufnr})
        -- vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true, buffer = bufnr })
      end


  end
})
