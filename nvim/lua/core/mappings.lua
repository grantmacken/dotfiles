-- Set space as leader key

local util = require('my.util')

-- NOTE! opt defaults to {silent = true}
local keymap = util.keymap -- function(mode, keys, rhs, desc, opts)
local nmap = util.nmap     -- function( keys, rhs, desc, opts)
local nmap_leader = util.nmap_leader        --  function(suffix, rhs, desc, opts)

-- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-completion.txt
--To get more consistent behavior of `<CR>`, you can use this template in your 'init.lua' to make customized mapping
local keys = {
    ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
    ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
    ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()['selected'] ~= -1
      return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys['cr']
    end
  end

keymap('i', '<CR>', 'v:lua._G.cr_action()', 'enter key mod', { expr = true })
nmap( '<C-z>', '<Nop>','Disable accidentally pressing Ctrl-Z', {})
nmap( 'Q', '<Nop>', 'Disable ex-mode', {})
nmap( '<esc>', '<cmd>nohlsearch<cr>','Turn off search highlighting',{})
-- Better command history navigation
-- vim.keymap.set('c', '<C-p>', '<Up>', { silent = false })
-- vim.keymap.set('c', '<C-n>', '<Down>', { silent = false })
--
-- TOGGLE
---- numbering
nmap_leader("tn", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, "Toggle numbering",{})

---- spelling
nmap_leader("ts", function() vim.opt.spell = not vim.opt.spell:get() end, "Toggle spelling", {})

-- BRACKETED

-- Diagnostic keymaps
nmap('[d', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message', {} )
nmap(']d', vim.diagnostic.goto_next,'Go to next [D]iagnostic message', {})

