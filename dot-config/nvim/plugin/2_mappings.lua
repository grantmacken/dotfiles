local m        = require('mod.keymaps')
local nLeader  = m.nLeader
local nMap     = m.nMap
local nxoMap   = m.nxoMap
local iMap     = m.iMap
local tMap     = m.tMap
--local nvMap    = m.nvMap
local nvLeader = m.nvLeader
local ok = nil


--[[ DIAGNOSTICS
--- NOTE
-- ## defaults ##
when in buffer with diagnostics
]d and [d   jump to next diagnostic
[D and ]D   jump to the first and last diagnostic in the current buffer
when on line with diagnostic
]] --
-- disable

nMap('<C-z>','<Nop>', 'Disable accidentally pressing Ctrl-Z and suspending Neovim')
nMap('Q','<Nop>', 'Disable ex mode')

-- tMap('<esc>', [[<C-\\><C-n>]], 'exit terminal')
-- Move between windows
nMap('<C-End>', function() vim.cmd('wincmd b') end,'goto bottom right')
tMap('<C-End>', function() vim.cmd('wincmd b') end,'goto bottom right')
nMap('<C-Home>', function() vim.cmd('wincmd t') end,'goto top left')
tMap('<C-Home>', function() vim.cmd('wincmd t') end,'goto top left')
nMap('<C-Down>', function() vim.cmd('wincmd j') end,'window command')
nMap('<C-Up>', function() vim.cmd('wincmd k') end,'window command')
nMap('<C-Left>', function() vim.cmd('wincmd h') end,'window command')
nMap('<C-Right>', function() vim.cmd('wincmd l') end,'window command')
tMap('<C-Right>', function() vim.cmd('wincmd l') end,'window command')
tMap('<C-Down>', function() vim.cmd('wincmd j') end,'window command')
tMap('<C-Up>', function() vim.cmd('wincmd k') end,'window command')
tMap('<C-Left>', function() vim.cmd('wincmd h') end,'window command')
tMap('<C-Del>',vim.cmd.hide,'window command hide')
--nMap('<C-Del>',vim.cmd.hide,'window command hide')
nMap('<C-s>',vim.cmd.write, 'oh windows what have you done to me')

--[[
copilot and chat
@see https://www.lazyvim.org/extras/ai/copilot-chat
--]]
-- Copilot

ok, chat = pcall(require, 'CopilotChat')
if ok then
  local select = require("CopilotChat.select")
  local actions = require("CopilotChat.actions")
  local integration = require('CopilotChat.integrations.fzflua')
  nvLeader('ax',chat.reset, 'Copilot Reset')
  nvLeader('aq', function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
      chat.ask(input,{ selection = select.buffer})
    end
  end, '[q]uick Chat (CopilotChat)')
  nLeader("ap",function()integration.pick(actions.prompt_actions())end,
  "[p]rompt actions (CopilotChat)")
  nvLeader('ta', function() require('CopilotChat').toggle() end, '[t]oggle Copilot Chat')
  nvLeader('ar', chat.reset,'[r]reset (CopilotChat)' )
  nLeader('as', chat.stop, '[s]top (CopilotChat)' )
  nLeader('am', chat.select_model,'select [m]odel (CopilotChat)' )
  nLeader('ta',chat.toggle, '[t]oggle Copilot Chat')
end

nLeader('tt', function() require('mod.terminals').toggle() end, '[t]erminal')
nLeader('tq', function() require('quicker').toggle() end, '[q]uickfix')
nLeader('tl', function() require('quicker').toggle({ loclist = true }) end, '[l]oclist')
nLeader('ti', function() vim.treesitter.inspect_tree() end, ' [i]nspectTree')

--[[ COMPLETIONS --]]

ok, suggestion = pcall(require, 'copilot.suggestion')
if ok then
  nLeader('tc',suggestion.toggle_auto_trigger,'start stop suggesting in  enter insert mode')
--[[
When auto_trigger is false, use the next or prev keymap to trigger copilot suggestion
<M-] : next suggestion
<M-[  : previous suggestion
<C-]> : dismiss suggestion
--]]
 iMap('<M-w>',suggestion.accept_word,' suggestion accept [w]ord' )
 iMap('<M-e>',suggestion.accept_line,' suggestion accept to line [e]nd' )
end
--[[
defaults
LSP @see plugin/5_lsp.lua
]]
nLeader('cf',function() require('fzf-lua').complete_file() end, '[comp] Path FZF completion')
nLeader('cp',function() require('fzf-lua').complete_path() end, '[comp] File FZF completion')
nLeader('cl',function() require('fzf-lua').complete_line() end, '[comp] Line FZF completion')
nLeader('cb',function() require('fzf-lua').complete_bline() end,'[comp] Buffer Line FZF completion')


nMap('-', function() vim.cmd.Oil() end,  '[oil] open parent directory')
nLeader('ff', require('fzf-lua').files,   '[FZF] Find Files ')
nLeader('bf', require('fzf-lua').buffers, '[FZF] buffers')

-- flash
nxoMap('s', function() require("flash").jump() end, "Flash")
nxoMap('S', function() require("flash").jump() end, "Flash Treesitter ")

-- b is for 'buffer'
-- nLeader('ba', 'Alternate')
nLeader('bd', function() require("mini.buffer").delete() end, 'Delete')
--nLeader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
--nLeader('bs', require('mod.buffers').new_scratch_buffer,    'Scratch')
--nLeader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',       'Wipeout')
--nLeader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>','Wipeout!')


-- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-completion.txt
--To get more consistent behavior of `<CR>`, you can use this template in your 'init.lua' to make customized mapping
-- local keys = {
--     ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
--     ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
--     ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
-- }
