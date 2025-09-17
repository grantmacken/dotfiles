-- Initialization =============================================================
--pcall(function()
 -- vim.loader.enable()
  -- vim.deprecate = function() end
--end)
-- disable built-in providers

local providers = { "node", "perl", "ruby", "python", "python3" }
for _, provider in ipairs(providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- disable built-in plugins
local plugins = { 'gzip', 'netrwPlugin', 'rplugin', 'tarPlugin', 'tohtml', 'tutor', 'zipPlugin', }
for _, plugin in ipairs(plugins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.mapleader = vim.keycode("<space>") -- Set leader key to space

local uv = vim.uv or vim.loop
-- Get the XDG data directory for Neovim
local data_dir = vim.fn.stdpath("data")
local pack_glob = data_dir .. "/site/pack/*/opt"
-- Expand all opt plugin directories
for _, opt_dir in ipairs(vim.fn.glob(pack_glob, true, true)) do
  local fd = uv.fs_scandir(opt_dir)
  if fd then
    while true do
      local plug_name, plug_type = uv.fs_scandir_next(fd)
      if not plug_name then break end
      if plug_type == "directory" then
        vim.cmd("packadd " .. plug_name)
      end
    end
  end
end

vim.cmd.colorscheme('kanagawa-wave')

---ICONS-
local ok_icons, icons = pcall(require, 'mini.icons')
if ok_icons then
  icons.setup()
end

-- NOTIFY
local ok_notify, miniNotify = pcall(require, 'mini.notify')
if ok_notify then
  local win_config = function()
    local has_statusline = vim.o.laststatus > 0
    local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
    return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
  end
  miniNotify.setup({ window = { config = win_config } })
  vim.notify = miniNotify.make_notify()
end

local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
local fd = uv.fs_scandir(lsp_dir)
if fd then
  while true do
    local server_name, server_type = uv.fs_scandir_next(fd)
    if not server_name then break end
    local name = server_name:match("(.+)%..+$")
    -- vim.notify( 'enabled LSP server:'  .. name)
    vim.lsp.enable( name )
  end
end




local keymap = require('util').keymap
keymap('<Leader>t', ':botright sp | term<CR>', 'Open [t]erminal')
keymap('<esc>',[[<C-\><C-n>]], 'Close [t]erminal','t')
-- keymap('<esc>',
--  function()
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-\\><C-n>', true, false, true), 'n', true)
--   vim.cmd('bd!')
-- end,
-- 'Close [t]erminal','t')
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

keymap('<Leader>r', ':restart<CR>', '[r]estart nvim')
-- keymap('<Leader>ll', function() vim.cmd.edit( vim.lsp.log.get_filename() ) end, '[L]sp [l]og')')
keymap('<leader>q', '<cmd>lua vim.diagnostic.setqflist()<CR>', 'set [q]uickfix list')

-- [ERROR][2025-09-10 19:47:13] /usr/local/share/nvim/runtime/lua/vim/lsp/log.lua:151	"inlinecompletion"	
-- { code = -32802, message = "Request was superseded by a new request", 
--  <metatable> = { __tostring = <function 1> } }
--

-- [ERROR][2025-09-18 06:27:12] /usr/local/share/nvim/runtime/lua/vim/lsp/log.lua:151	
-- "rpc"	"lua-language-server"	"stderr"	
-- "/usr/local/share/mason/packages/lua-language-server/libexec/bin/lua-language-server: create_directories: 
-- \"/usr/local/share/mason/packages/lua-language-server/libexec/log/cache/122447\": 
-- (generic:13)Permission denied\nstack traceback:\n\t[C]: 
-- in function 'bee.filesystem.create_directories'\n\tscript/service/service.lua:263: 
-- in function 'service.lockCache'\n\tscript/service/service.lua:286: in function 
-- 'service.start'\n\t...hare/mason/packages/lua-language-server/libexec/main.lua:82: in main chunk\n\t(bootstrap.lua):85: in main chunk\n\t[C]: in ?\n"

local group = vim.api.nvim_create_augroup('my_group', {})
local au = function(event, pattern, callback, desc)
    vim.api.nvim_create_autocmd(event, { group = group, pattern = pattern, callback = callback, desc = desc })
end

--- Highlight on yank
au('TextYankPost', '*',function() vim.hl.on_yank() end,'Highlight yanked text')

local start_terminal_insert = vim.schedule_wrap(function(data)
  -- Try to start terminal mode only if target terminal is current
  if not (vim.api.nvim_get_current_buf() == data.buf and vim.bo.buftype == 'terminal') then return end
  vim.cmd('startinsert')
end)
au('TermOpen', 'term://*', start_terminal_insert, 'Start builtin terminal in Insert mode')

--vim.opt.rtp:prepend('/usr/share/nvim/site')
