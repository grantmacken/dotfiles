vim.g.mapleader = ' ' -- Use space as the one and only true Leader key
vim.g.maplocalleader = ' '

--- Disable some built-in Neovim plugins
local builtins = {
  'tar',
  'zip',
  'gzip',
  'tarPlugin',
  'zipPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
}

for _, builtin in ipairs(builtins) do
  vim.g['loaded_' .. builtin] = 1
end

--- Disable some built-in Neovim plugins

local providers = { 'perl', 'node', 'ruby', 'python', 'python3' }
for _, provider in ipairs(providers) do
  vim.g['loaded_' .. provider .. '_provider'] = 0
end

 -- vim.cmd('filetype plugin indent on') -- Enable all filetype plugins

-- opts explain with camelcase local:
-- Disable swapfiles and enable undofiles
local smooth_mouse_scroll =  { 'hor:1', 'ver:1' }
-- local fill_chars = {foldopen = '',foldclose = '',fold = ' ',foldsep = ' ',diff = '╱',eob = ' ',}
local fill_chars = { eob = ' ', horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', 
vertright = '┣', verthoriz = '╋', fold = ' ', diff = '─', msgsep = '‾', foldsep = '│', foldopen = '▾',
foldclose = '▸', }
-- Define which helper symbols to show
local list_chars =  { tab = '▸ ', trail = '·',extends = '…', precedes = '…', nbsp = '␣' }
-- local list_chars =  = 'tab:> ,extends:…,precedes:…,nbsp:␣' 

-- sorted  opts to avoid dups
local opt = vim.opt
opt.autowrite      = true -- Enable auto write
opt.backup         = false -- Don't store backup while overwriting the file
opt.breakindent    = true    -- Indent wrapped lines to match line start
opt.clipboard      = 'unnamedplus' -- Sync with system clipboard
opt.cmdheight      = 0 -- hide command line unless needed
opt.colorcolumn    = '120'
opt.completeopt    = 'menu,menuone,noselect' -- Customize completions
opt.conceallevel   = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm        = true -- Confirm to save changes before exiting modified buffer
opt.cursorline     = true    -- Highlight current line
opt.expandtab      = true -- Use spaces instead of tabs
opt.fillchars      = fill_chars
opt.foldlevel       = 6
opt.foldcolumn = 'auto:2'
opt.formatoptions  = 'qjl1'                      -- Don't autoformat comments
opt.grepformat     = '%f:%l:%c:%m'
opt.grepprg        = 'rg --vimgrep'
opt.hlsearch       = true
opt.ignorecase     = true -- Ignore case when searching (use `\C` to force not doing that)
opt.inccommand     = 'nosplit' -- preview incremental substitute
opt.incsearch      = true -- Show search results while typing
opt.infercase      = true -- Infer letter cases for a richer built-in keyword completion
opt.laststatus     = 3    -- Use global statusline
opt.linebreak      = true    -- Wrap long lines at 'breakat' (if 'wrap' is set)
opt.list           = true -- Show some invisible characters (tabs...
opt.listchars      = list_chars
opt.mouse          = 'a'   -- Enable mouse for all available modes
opt.mousescroll  = smooth_mouse_scroll -- Customize mouse scroll
opt.number         = true  -- Show line numbers
opt.pumblend       = 10 -- Make builtin completion menus slightly transparent
opt.pumheight      = 10 -- Make popup menu smaller
opt.relativenumber = true -- Relative line numbers
opt.ruler          = false   -- Don't show cursor position in command line
opt.scrolloff      = 10 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround     = true -- Round indent
opt.shiftwidth     = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Reduce command line messages
opt.showmode      = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 6 -- Columns of context
opt.signcolumn    = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase     = true -- Don't ignore case when searching if pattern has upper case
opt.smartindent   = true -- Insert indents automatically
opt.smoothscroll  = true
opt.spelllang     = { 'en' }
opt.splitbelow    = true -- Put new windows below current
opt.splitkeep     =  'screen'
opt.splitright    = true -- Put new windows right of current
opt.swapfile      = false
opt.switchbuf      = 'usetab'   -- Use already opened buffers when switching
opt.tabstop       = 2 -- Number of spaces tabs count for
--opt.termguicolors = true -- default
opt.timeoutlen    = 600
opt.undofile      = true  -- Enable persistent undo (see also `:h undodir`)
opt.undolevels    = 10000
opt.updatetime    = 400 -- time it takes to trigger the `CursorHold` event
opt.virtualedit   = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode      = 'longest:full,full' -- Command-line completion mode
opt.winblend      = 10 -- Make floating windows slightly transparent
opt.winminwidth   = 5 -- Minimum window width
opt.wrap          = false   -- Display long lines as just one line
opt.writebackup   = false -- Don't store backup while overwriting the file

-- misc
opt.foldlevel = 99
-- vim.opt.foldmethod = "expr"
opt.showtabline = 0 -- never show tabs, 1 is default, 2, -- always show tabs
-- Set cursor coloring in the terminal
vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor25-Cursor"

-- Spelling ===================================================================
opt.iskeyword:append('-')  -- Treat dash separated words as a word text object
opt.spelllang      = 'en'   -- Define spelling dictionaries
-- opt.spell          =  false 
opt.spelloptions = 'camel,noplainbuffer' -- Treat parts of camelCase words as seprate words
opt.spellsuggest = 'best,6'
-- vim.opt.complete:append('kspell') -- Add spellcheck options for autocomplete
-- vim.opt.complete:remove('t')      -- Don't use tags for completion
--



