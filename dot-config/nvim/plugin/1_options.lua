--globals
vim.cmd("colorscheme kanagawa")
vim.cmd('filetype plugin indent on') -- Enable all filetype plugins
vim.g.mapleader        = ' '         -- Use space as the one and only true Leader key
local opt              = vim.opt
-- WINDOW CHROME
vim.o.signcolumn       = "yes"
vim.o.showmode         = false         -- Dont show mode since we have a statusline
vim.o.number           = true          -- Show line numbers
vim.o.relativenumber   = false         -- Relative line numbers
vim.o.laststatus       = 3             -- Global statusline
vim.o.cmdheight        = 0             -- Hide command line unless needed
vim.o.ruler           = false         -- Don't show cursor position in command line
vim.o.winminwidth      = 5             -- Minimum window width
vim.opt.title          = true          -- Vim will change terminal title
vim.opt.titlestring = "%{getpid().':'.getcwd()}"
-- CLIPBOARD KEYBOARD MOUSE
vim.o.clipboard        = "unnamedplus" -- Sync with system clipboard
vim.o.timeoutlen       = 1000          -- modal keys --300
vim.o.ttimeoutlen      = 10
vim.o.mouse            = 'a'           -- Enable mouse for all available modes
vim.opt.spelllang      = { "en" }
-- EDITING BLING
vim.o.wrap             = false -- Display long lines as just one line
vim.o.breakindent      = true  -- Indent wrapped lines to match line start
vim.o.colorcolumn      = "120" -- Highlight current line
vim.o.cursorline       = true  -- Highlight current line
vim.o.expandtab        = true  -- Use spaces instead of tabs
vim.o.list             = true  -- Show some invisible characters (tabs...
vim.o.shiftround       = true  -- Round indent
vim.o.shiftwidth       = 2     -- Size of an indent
vim.o.scrolloff        = 10    -- Lines of context
vim.o.sidescrolloff    = 8     -- Columns of context
vim.o.smartindent      = true  -- Insert indents automatically
vim.o.smoothscroll     = true
vim.o.tabstop          = 4
vim.o.virtualedit      = "block" -- Allow cursor to move where there is no text in visual block mode
vim.opt.fillchars      = { foldopen = "", foldclose = "", fold = "-", foldsep = " ", diff = "╱", eob = " ", }
vim.opt.listchars      = table.concat({ 'extends:…', 'nbsp:␣', 'precedes:…', 'tab:> ' }, ',') -- helper symbols to show
-- SPLITING WINDOWS
opt.splitbelow         = true -- Put new windows below current
opt.splitkeep          = "screen"
opt.splitright         = true -- Put new windows right of current
-- SEARCHING
vim.o.smartcase        = true
vim.o.hlsearch         = true
vim.o.ignorecase       = true    -- Ignore case when searching (use `\C` to force not doing that)
vim.o.inccommand       = "split" -- preview incremental substitute
vim.o.incsearch        = true    -- Show search results while typing
-- UNDO RESTORE
--vim.o.shortmess     = 'aoOWFcSC'                      -- Reduce command line messages
vim.o.shada            = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file
vim.o.autowrite        = true                             -- Enable auto write
vim.o.backup           = false                            -- Don't store backup while overwriting the file
vim.o.undofile         = true
vim.o.undolevels       = 10000
vim.o.updatetime       = 200
vim.o.confirm          = true  -- Confirm to save changes before exiting modified buffer
vim.o.swapfile         = false -- bye bye
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
-- COMPLETING
vim.o.infercase        = true -- Infer letter cases for a richer built-in keyword completion
vim.opt.completeopt    = { 'menu', 'menuone', 'noinsert', 'noselect' }
vim.o.pumblend         = 0
vim.o.winblend         = 0
vim.o.pumheight        = 10                  -- Make popup menu smaller
vim.o.smartcase        = true                -- Don't ignore case with capitals
vim.o.wildmode         = "longest:full,full" -- Command-line completion mode
-- FOLDING
vim.o.foldcolumn       = "0"
vim.o.foldenable       = true
vim.o.foldlevel        = 99
vim.o.foldlevelstart   = 99
vim.o.foldmethod       = "expr"
vim.o.foldexpr         = "v:lua.vim.treesitter.foldexpr()"

--
--opt.shortmess:append('WcC') -- Reduce command line messages
--
--vim.o.formatoptions = 'qjl1'                          -- Don't autoformat comments
--vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

--opt.complete:remove('t')           -- Don't use tags for completion

--opt.grepformat    = "%f:%l:%c:%m"
--opt.grepprg       = "rg --vimgrep"
-- opt.guicursor      = ''

-- opt.tabstop            = 2    -- Number of spaces tabs count for
-- opt.termguicolors      = true -- True color support
-- opt.undofile           = true -- Enable persistent undo (see also `:h undodir`)
-- opt.undolevels         = 10000
-- --opt.updatetime    = 250                  -- Save swap file and trigger CursorHold
-- opt.winblend           = 0     -- Have no transparency to always have "overflow" icons
-- opt.writebackup        = false -- Don't store backup while overwriting the file


--
-- vim.opt.foldlevel = 99
-- TODO!
-- vim.opt.foldtext = "v:lua.require'ak.util'.ui.foldtext()"
-- vim.opt.statuscolumn = [[%!v:lua.require'ak.util'.ui.statuscolumn()]]
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.require'ak.util'.ui.foldexpr()"
-- vim.opt.foldmethod = "indent"
--

--opt.shortmess:append({ W = true, I = true, c = true, C = true })
--
--
-- opt.formatoptions  = "jcroqlnt" -- tcqj
--opt.fillchars      = 'eob: ' -- Don't show `~` outside of buffer
--
-- opt.completeopt = "menu,menuone,noselect"
