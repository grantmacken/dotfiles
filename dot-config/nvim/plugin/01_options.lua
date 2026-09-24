-- vim.cmd('filetype plugin indent on')      -- Enable all filetype plugins
-- vim.cmd([[ highlight iCursor guibg=#FFFF00 guifg=#000000 ]])
-- vim.o.guicursor     = "n-v-c:block,i:ver100-iCursor"

-- TERMINAL
vim.o.termguicolors = true            -- Enable 24-bit RGB color in the Terminal UI
vim.o.background    = "dark"          -- Set background color to dark
vim.o.shell         = "/usr/bin/bash" -- Set default shell to bash
vim.o.scrollback    = 1000000         -- max scrollback (default 10000)

--[[ LISTS
## Docs
  - https://neovim.io/doc/user/options.html#'formatlistpat'
  - https://neovim.io/doc/user/options.html#'formatoptions'
]]
-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat  = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- FILE HANDLING
vim.o.exrc           = false                            -- Enable project local .nvimrc files
-- General
vim.o.mouse          = 'a'                              -- Enable mouse
vim.o.mousescroll    = 'ver:25,hor:6'                   -- Customize mouse scrolling speed
vim.o.switchbuf      = 'usetab'                         -- Use already opened buffers when switching
vim.o.shada          = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)
vim.o.autoread       = true                             -- Auto read file changes
vim.o.updatetime     = 200                              -- Faster completion

-- WINDOW CHROME
vim.o.signcolumn     = "yes"     -- Always show signcolumn (less flicker)
vim.o.showmode       = false     -- Dont show mode since we have a statusline
vim.o.showtabline    = 0         -- Never show tabline
vim.o.number         = true      -- Show line numbers
vim.o.relativenumber = true      -- Relative line numbers
vim.o.laststatus     = 3         -- Global statusline
vim.o.cmdheight      = 0         -- Hide command line unless needed
vim.o.ruler          = false     -- Don't show cursor position in command line
vim.o.winminwidth    = 5         -- Minimum window width
vim.opt.title        = true      -- Vim will change terminal title
vim.o.winborder      = 'rounded' -- Border style for floating windows
-- vim.opt.titlestring    = "%{getpid().':'.getcwd()}"
-- CLIPBOARD KEYBOARD MOUSE
vim.o.clipboard      = "unnamedplus" -- Sync with system clipboard
vim.o.timeoutlen     = 1000          -- modal keys --300
vim.o.ttimeoutlen    = 10
vim.opt.spelllang    = { "en" }

-- EDITING BLING
vim.o.spelloptions   = 'camel'             -- Treat camelCase word parts as separate words
vim.o.formatoptions  = 'rqnl1j'            -- Improve comment editing
vim.o.autoindent     = true                -- Use auto indent
vim.o.cursorlineopt  = 'screenline,number' -- Show cursor line per screen line--
vim.o.wrap           = false               -- Display long lines as just one line
vim.o.linebreak      = true                -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.breakindent    = true                -- Indent wrapped lines to match line start
vim.o.breakindentopt = 'list:-1'           -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn    = '+1'                -- Draw column on the right of maximum width
vim.o.cursorline     = true                -- Highlight current line
vim.o.expandtab      = true                -- Use spaces instead of tabs
vim.o.shiftround     = true                -- Round indent
vim.o.shiftwidth     = 2                   -- Size of an indent
vim.o.scrolloff      = 10                  -- Lines of context
vim.o.sidescrolloff  = 8                   -- Columns of context
vim.o.smartindent    = true                -- Insert indents automatically
vim.o.smoothscroll   = true
vim.o.tabstop        = 4
vim.o.virtualedit    = "block" -- Allow cursor to move where there is no text in visual block mode
vim.o.fillchars      = 'eob: ,fold:╌'

--"▷ ⋯",
vim.o.list           = true -- Show some invisible characters (tabs...
vim.o.listchars      = 'extends:…,nbsp:␣,precedes:…,tab:> '

vim.o.iskeyword      = '@,48-57,_,192-255,-' -- Treat dash separated words as a word text object
-- SPLITING WINDOWS
vim.opt.splitbelow   = true                  -- Put new windows below current
vim.opt.splitkeep    = "screen"
vim.opt.splitright   = true                  -- Put new windows right of current

-- UNDO RESTORE
vim.o.autowrite      = true  -- Enable auto write
vim.o.backup         = false -- Don't store backup while overwriting the file
vim.o.undofile       = true  -- Enable persistent undo (see also `:h undodir`)
vim.o.undolevels     = 10000 -- 10x more undo levels
vim.o.confirm        = true  -- Confirm to save changes before exiting modified buffer
vim.o.swapfile       = false -- bye bye

vim.o.more           = false
vim.opt.shortmess:append('WcC') -- Reduce command line messages
