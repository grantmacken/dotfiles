--[[ lsp setup
 - [ ] md section: reference links:  'gf' & `gx`  file and url
 - [ ] md section: documenting built-in keybindings
 - [ ] enable all LSP servers in the 'lsp' config directory [lsp_enable]
 - [ ] checklist: enable LSP features based on server capabilities [server_capabilities]
--]]

--[[ LSP and Diagnostics Keymaps and Features
## GLOBAL KEYMAPS
These GLOBAL keymaps are created **unconditionally** when Nvim starts:
 - "gra" (Normal and Visual mode) is mapped to vim.lsp.buf.code_action()
 - "gri" is mapped to vim.lsp.buf.implementation()
 - "grn" is mapped to vim.lsp.buf.rename()
 - "grr" is mapped to vim.lsp.buf.references()
 - "grt" is mapped to vim.lsp.buf.type_definition()
 - "gO" is mapped to vim.lsp.buf.document_symbol()
 - CTRL-S (Insert mode) is mapped to vim.lsp.buf.signature_help()
 - "an" and "in" (Visual and Operator-pending mode) are mapped to
outer and inner incremental selections, respectively,
using vim.lsp.buf.selection_range()

BUFFER-LOCAL DEFAULTS
 - 'omnifunc' is set to vim.lsp.omnifunc(), use i_CTRL-X_CTRL-O to trigger completion.
 - 'tagfunc' is set to vim.lsp.tagfunc(). This enables features like go-to-definition, :tjump, and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server.
 - 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
    - To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
 - K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
 - Document colors are enabled for highlighting color references in a document.
   - To opt out call vim.lsp.document_color.enable(false, args.buf) on LspAttach.

https://neovim.io/doc/user/lsp.html#_lua-module:-vim.lsp.buf

--]]


-- --[[ Show signature information about the symbol under the cursor
--  - when: cursor position on symbol
--  - keymap:  CTRL-S (Insert mode)
--  - trigger:  - display: floating window.'
-- --]]
--
-- vim.lsp.buf.signature_help({
--   border = 'rounded', -- 'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
--   title = 'Signature help',
--   title_pos = 'center',
--   max_height = math.floor(vim.o.lines * 0.5),
--   max_width = math.floor(vim.o.columns * 0.4),
-- })

--[[ Show hover information about the symbol under the cursor
 - when: cursor position on symbol
 - keymap: K, KK to enter the hover window and use q to close it
 - trigger:  - display: floating window.'
--]]
-- vim.lsp.buf.hover({
--   border = 'rounded', -- 'none' | 'single' | 'double' | 'rounded' | 'solid' | 'shadow'
--   max_height = math.floor(vim.o.lines * 0.5),
--   max_width = math.floor(vim.o.columns * 0.4),
-- })
--



--[[ lsp_enable ]] --
local uv = vim.uv or vim.loop
local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local fd = uv.fs_scandir(lsp_dir)
if fd then
  while true do
    local server_name, _ = uv.fs_scandir_next(fd)
    if not server_name then break end
    local name = server_name:match("(.+)%..+$")
    vim.lsp.enable(name)
    vim.notify_once('enabled LSP server:' .. name, vim.log.levels.INFO)
  end
end


-- HACK: Override buf_request to ignore notifications from LSP servers that don't implement a method.
local buf_request = vim.lsp.buf_request
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf_request = function(bufnr, method, params, handler)
  return buf_request(bufnr, method, params, handler, function() end)
end

--[[

--   if client:supports_method('textDocument/foldingRange') then
--     local win = vim.api.nvim_get_current_win()
--     vim.wo[win][bufID].foldexpr = 'v:lua.vim.lsp.foldexpr()'
--   end
--   -- definitions
--   if client:supports_method('textDocument/definition') then
--     vim.bo[bufID].tagfunc = 'v:lua.vim.lsp.tagfunc()'
--   end
--   -- autocmd to format on save if supported
--   if client:supports_method('textDocument/formatting') then
--     vim.api.nvim_create_autocmd('BufWritePre', {
--       buffer = bufID,
--       callback = function()
--         vim.lsp.buf.format({ bufID = bufID })
--       end,
--       desc = 'Format on save',
--     })
--   end
-- end,
-- ]]

--[[ server_capabilities ]] --
--[[ Checklist of  LSP features based on server capabilities
' Features supported:
 - definitions:  keymap: gd:
                 display: quickfix list
 - references:  keymap: gr
                display: quickfix list
 - code actions: keymap: gra (Normal and Visual mode)
 - hover:       keymap K, KK to enter the hover window and use q to close it
                         Show hover information about the symbol under the cursor in a floating window.
 - folding ranges:       keymap: za, zc, zo, zm, zr, zR`
 - signatures help:      keymap:  CTRL-S (Insert mode)
                         Show signature information about the symbol under the cursor in a floating window.'

- [ ] completions:          keymap: <C-Space>
- [ ] inline completions:   keymaps: <Tab>, <M-n>, <M-p>
- [ ] formatting on save:   BufWritePre
--]]

--- Set up buffer-local keymaps for LSP features
--- @param keymap table A table containing the keymap definition in the format { lhs, rhs, desc }
--- @param mode string The mode in which the keymap should be set (e.g 'n' for normal mode, 'i' for insert mode, etc.)
--- @param bufID? number
local set_keymap = function(keymap, mode, bufID)
  bufID = bufID or 0
  vim.keymap.set(mode, keymap[1], keymap[2], { buffer = bufID, desc = keymap[3] })
end

--- Set up buffer-local keymaps for LSP features that require dynamic evaluation
--- @param keymap table A table containing the keymap definition in the format { lhs, rhs, desc }
--- @param mode string The mode in which the keymap should be set (e.g 'n' for normal mode, 'i' for insert mode, etc.)
--- @param bufID? number
local set_dynamic_keymap = function(keymap, mode, bufID)
  bufID = bufID or 0
  vim.keymap.set(mode, keymap[1], keymap[2], { expr = true, buffer = bufID, desc = keymap[3] })
end

--[[
  Enable LSP completions if the client supports it.
  This function is called on LspAttach to enable completions for the buffer.
  It also sets up a keymap for triggering completions in insert mode.
--]]
---@param oClient table The LSP client object.
---@param bufID number The buffer number.
local completions = function(oClient, bufID)
  if not oClient:supports_method('textDocument/completion') then return end
  -- vim.bo[bufID].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  --[[
The LSP `triggerCharacters` field decides when to trigger autocompletion.
here we limit it to a few characters that are common in programming languages,
 TODO: make this configurable per language server, or per filetype.
--]]
  --
  -- Optional: trigger autocompletion on EVERY keypress. May be slow!
  -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
  -- local chars = { '.', ':', '#', '(' }
  -- if type(oClient.server_capabilities.completionProvider.triggerCharacters) == 'table' then
  --   vim.print(oClient.server_capabilities.completionProvider.triggerCharacters)
  --   -- oClient.server_capabilities.completionProvider.triggerCharacters = chars
  -- end
  -- completion = {
  --  completionItem = {
  --    commitCharactersSupport = true,
  --[[
If the server provides `commitCharacters` for a completion item, typing one of
those characters while the item is selected accepts the completion and then
inserts the character.
--]]

  vim.lsp.completion.enable(true, oClient.id, bufID, {
    autotrigger = true,
    commit_characters = false,
    convert = function(item)
      return { abbr = item.label:gsub('%b()', '') }
    end,
  })
  --vim.keymap.set("i", "<INS>", "<C-x><C-o>", { desc = "Trigger completion" })
  -- set_keymap({ '<INS>', vim.lsp.completion.get, "Trigger lsp completion" }, 'i', bufID)
end

local inline_completion = function(oClient, bufID)
  if not oClient:supports_method('textDocument/inlineCompletion') then return end
  vim.lsp.inline_completion.enable(true)
  set_dynamic_keymap(
    { '<C-Space>',
      function() if not vim.lsp.inline_completion.get() then return '<C-Space' end end,
      'Accept the current inline completion' }
    , 'i')
  set_keymap(
    { '<M-n>', function() vim.lsp.inline_completion.select({ bufID = bufID }) end,
      'Show next inline completion suggestion' }, 'i')
  set_keymap(
    { '<M-p>', function() vim.lsp.inline_completion.select({ bufID = bufID, count = -1 }) end,
      'Show previous inline completion suggestion' }, 'i')
end

local formating = function(oClient, bufID)
  -- autocmd to format on save if supported
  if oClient:supports_method('textDocument/formatting') then
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufID,
      callback = function()
        vim.lsp.buf.format({ bufID = bufID })
      end,
      desc = 'Format on save',
    })
  end
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP',
  callback = function(args)
    local clientID = args.data.client_id
    local oClient = vim.lsp.get_client_by_id(clientID)
    local bufID = args.buf
    if not oClient then
      return
    end
    -- local oCapabilties = vim.lsp.protocol.make_client_capabilities()
    -- vim.print(vim.lsp.protocol.resolve_capabilities(oCapabilties))
    completions(oClient, bufID)
    inline_completion(oClient, bufID)
    formating(oClient, bufID)
  end
})

vim.api.nvim_create_autocmd('LspDetach', {
  desc = 'LSP Detaching',
  group = vim.api.nvim_create_augroup("UserLspDetach", { clear = true }),
  callback = function(args)
    local bufID = args.buf
    local clientID = args.data.client_id
    -- Get the attaching client
    local oClient = vim.lsp.get_client_by_id(clientID)
    -- Don't check for the capability here to allow dynamic registration of the request.
    -- Remove the autocommand to format the buffer on save, if it exists
    if oClient:supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({
        event = 'BufWritePre',
        buffer = bufID,
      })
    end
  end
}
)
