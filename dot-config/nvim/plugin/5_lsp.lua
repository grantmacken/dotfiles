--[[
When the Nvim LSP client starts it enables diagnostics @see './diagnostic.lua'
LSP DEFAULTS:
NOTE: do not overide by duplicating in lsp attach
- 'omnifunc' is set to |vim.lsp.omnifunc()
- 'tagfunc' is set to |vim.lsp.tagfunc()|. This enables features like
  go-to-definition, |:tjump|, and keymaps like  |CTRL-]|, |CTRL-W_]|, |CTRL-W_}| to utilize the language server.
- 'formatexpr' is set to |vim.lsp.formatexpr()|, so you can format lines via |gq| if the language server supports it.
- To opt out of this use |gw| instead of gq, or clear 'formatexpr' on |LspAttach|.
- |K| is mapped to |vim.lsp.buf.hover()| unless |'keywordprg'| is customized or a custom keymap for `K` exists.

 --Some keymaps are created unconditionally when Nvim starts:
 --NOTE: do not overide
 --TO Nice list https://github.com/boltlessengineer/NativeVim/blob/main/lua/core/lsp.lua
 --
 NORMAL MODE                -
Ctrl+W+] : definition in *new* window
Ctrl+W+} : definition in *preview* window
gra      : code action     - vim.lsp.buf.code_action()    - into prompt to select code action available
## when symbol under cursor
grn      : rename          - vim.lsp.buf.rename()|        - into prompt
gri      : implementation - vim.lsp.buf.implementation()  - into quickfix list all implementation for symbol
grr      : references     - vim.lsp.buf.references()      - into quickfix list all the references to the symbol
K        : hover          - vim.lsp.buf.hover()           - into float information about the symbol
Ctrl+]   : definition     - vim.lsp.buf.definition()      - jump to the definition of the symbol
## when in buffer
Ctrl+t   : definition                                      -jump back from definition in the the tag stack
gO       : symbols        - vim.lsp.buf.document_symbol() - into quickfix all document symbols for the buffer
--
VISUAL MODE
gq       : format lines    - vim.lsp.buf.format()
gra      : code action     - vim.lsp.buf.code_action()

INSERT MODE
CTRL-S   : signature        - vim.lsp.buf.signature_help() -- into float
CTRL-X_CTRL-O: completion  - vim.lsp.completion.trigger()

- "grn" is mapped in Normal mode to |vim.lsp.buf.rename()|
- "gra" is mapped in Normal and Visual mode to |vim.lsp.buf.code_action()|
- "grr" is mapped in Normal mode to |vim.lsp.buf.references()|
- "gri" is mapped in Normal mode to |vim.lsp.buf.implementation()|
- "gO" is mapped in Normal mode to |vim.lsp.buf.document_symbol()|
- CTRL-S is mapped in Insert mode to |vim.lsp.buf.signature_help()

Not all language servers provide the same capabilities.
Use capability checks to ensure you only use features supported by the language server.
:lua =vim.lsp.get_clients()[1].server_capabilities
Not all language servers provide the same capabilities. Use
capability checks to ensure you only use features supported by the language
server.
]] --

-- h vim.lsp.completion.BufferOpts
-- do not use lsp servers trigger chars
local completionBufferOpts = { autotrigger = false }

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(args)
    local bufnr = args.buf
    local client_id = args.data.client_id
    local bufmap = function(mode, lhs, rhs, desc)
      local opts = { buffer = args.buf, desc = desc }
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local client = vim.lsp.get_client_by_id(client_id)
    -- if client.supports_method('textDocument/implementation') then
    --   -- Create a keymap for vim.lsp:luafilr.buf.implementation
    -- end
    --
    -- Keyboard shortcut to trigger lsp completion  vim.lsp.completion.trigger()
    if client.supports_method('textDocument/completion') then
      -- Enable auto-completion but do not auto trigger
      vim.lsp.completion.enable(true, client_id, bufnr, completionBufferOpts)
      bufmap('i', '<C-Space>', '<C-x><C-o>', 'Trigger code completion')
    end

    if client.supports_method('textDocument/inlayHint') then
      -- Format the current buffer on save
    end

    -- Keyboard shortcut to open diagnostic float vim.diagnostic.open_float()
     if client.supports_method('textDocument/diagnostic') then
    --  --vim.diagnostic.enable(bufnr)
    -- bufmap('n', '<F2>','<C-w><C-d>', 'diagnostic open float')
    --   -- bufmap('i', '<Alt-Space>',function() end)
     end

    if client.supports_method('textDocument/inlayHint') then
      -- Format the current buffer on save
    end
    if client.supports_method('textDocument/codeLens') then
      -- Format the current buffer on save
    end
  end,
})

vim.api.nvim_create_autocmd('LspDetach', {
  callback = function(args)
    -- Get the detaching client
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Remove the autocommand to format the buffer on save, if it exists
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        buffer = args.buf,
      })
    end
  end,
})


--[[
LspNotify                                                          *LspNotify*
    This event is triggered after each successful notification sent to an
    LSP server.

 vim.api.nvim_create_autocmd('LspNotify', {
      callback = function(args)
        local bufnr = args.buf
        local client_id = args.data.client_id
        local method = args.data.method
        local params = args.data.params

        -- do something with the notification
        if method == 'textDocument/...' then
          update_buffer(bufnr)
        end
      end,
    })

see also
LspProgress

LspRequest
LspTokenUpdate
]] --

vim.api.nvim_create_user_command("LspCapabilities", function()
  local curBuf = vim.api.nvim_get_current_buf()
  local client = vim.lsp.get_active_clients({ bufnr = curBuf })[1]
  --vim.print(vim.tbl_keys(client))
  --vim.notify(client.name)
  vim.print(vim.tbl_keys(client.server_capabilities))
end, {})

vim.api.nvim_create_user_command("LspHandlers", function()
  vim.print(vim.tbl_keys(vim.lsp.handlers))
end, {})
