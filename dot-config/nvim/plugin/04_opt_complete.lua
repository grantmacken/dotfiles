--[[ Completions
## Docs
  - https://neovim.io/doc/user/options.html#'complete'
  - https://neovim.io/doc/user/options.html#'completeopt'
  - https://neovim.io/doc/user/options.html#'wildmode'
  - https://neovim.io/doc/user/options.html#'wildoptions'
  - https://neovim.io/doc/user/options.html#'wildignore'
  - https://neovim.io/doc/user/options.html#'wildignorecase'
  - https://neovim.io/doc/user/options.html#'wildmenu'
  - https://neovim.io/doc/user/options.html#'wildchar'
  - https://neovim.io/doc/user/options.html#'wildcharm'
  - https://neovim.io/doc/user/options.html#'completefuzzycollect'
  - https://neovim.io/doc/user/options.html#'completefuzzy'

## Built-in keybindings
CTRL-N: select next completion item
CTRL-P: select previous completion item
Left Right: select previous/next match (like CTRL-P/CTRL-N)
PageUp:  select a match several entries back
PageDown:  select a match several entries further
Up:  in filename/menu name completion: move up into parent directory or parent menu.
Down:  in filename/menu name completion: move into a subdirectory or submenu.
CR:  in menu completion, when the cursor is just after a dot: move into a submenu.
CTRL-E:  end completion, go back to what was there before selecting a match.
CTRL-Y:  accept the currently selected match and stop completion.

The "f" flag of :vimgrep enables fuzzy matching

To enable fuzzy matching for ins-completion, add "fuzzy" to the
'completeopt' option.  For cmdline-completion, add "fuzzy" to the
'wildoptions' option.

]] --

-- Controls display of file messages (e.g. CTRL-G) and various other messages.
vim.o.shortmess    = 'FOSWaco' -- Disable certain messages from ins-completion-menu
--
vim.o.autocomplete = false     -- boolean (default off)
-- --[[ global or local to buffer
--   When on, Vim shows a completion menu as you type, similar to using
--   i_CTRL-N, but triggered automatically.  See ins-autocompletion.
-- --]]
-- vim.o.autocompletedelay = 1    -- number	(default 0)
-- vim.o.autocompletetimeout = 60 -- global: number (default 80)
-- vim.o.complete = 'o,.^5,w^5,b^5,u^5,U^5,t^5'
-- vim.o.complete = 'o^5'
-- vim.o.complete = '.,w,b,u,U.t'
--[[ complete (default ".,w,b,u,t")
This option controls how completion |ins-completion| behaves when
using CTRL-P, CTRL-N, or |ins-autocompletion|
  '.' scan the current buffer ('wrapscan' is ignored)
  '.' scan the current buffer ('wrapscan' is ignored)
 'w': scan buffers from other windows
 'u' scan the unloaded buffers that are in the buffer list
 'U' scan the buffers that are not in the buffer list
 't' tag completion
--]]

vim.o.completeopt = 'menu,menuone,noselect,fuzzy,nosort,popup' -- Insert mode completion options
-- A comma-separated list of options for Insert mode completion
-- fuzzy:   Enable |fuzzy-matching| for completion candidat
-- menu:    Use a popup menu to show the possible completions
-- menuone  Use the popup menu also when there is only one match
-- popup    Show extra information about the currently selected

-- 'completeitemalign' (default "abbr,kind,menu")
vim.o.infercase   = true -- Infer case in built-in completion
--[[ INSERT COMPLETION POPUP MENU
--]]
vim.o.pumblend       = 0
vim.o.winblend       = 0
vim.o.pumheight      = 5  -- Make popup menu smaller
vim.o.pummaxwidth    = 80 -- Limit maximum width of popup menu

vim.o.wildmenu       = true
vim.o.wildignorecase = true
vim.o.wildchar       = '<Tab>'
vim.o.wildmode       = "noselect:lastused,longest:full"
vim.o.wildoptions    = { 'pum', 'fuzzy' }                                                  --default is pum, tagfile
-- Currently fuzzy matching based completion is not supported for file and directory names and instead wildcard expansion is used.                                                       -- Show popup menu for wildmenu
vim.o.wildignore     = { '**/node_modules/**', '**/.git/**', '**/dist/**', '**/build/**' } -- Ignore these files when completing


-- vim.keymap.set('i', '<Tab>', function()
--   if vim.fn.pumvisible() == 1 then
--     return '<C-n>'
--   else
--     return '<Tab>'
--   end
-- end, { expr = true, silent = true })
--
-- vim.keymap.set('i', '<S-Tab>', function()
--   if vim.fn.pumvisible() == 1 then
--     return '<C-p>'
--   else
--     return '<S-Tab>'
--   end
-- end, { expr = true, silent = true })
