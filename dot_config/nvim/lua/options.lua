local M = {}

local log = function(msg)
  local fp = io.open( 'my.log', "a")
  fp:write(string.format("[%-6s%s] %s\n", 'INFO', os.date(), msg))
  fp:close()
end

local setup = function()
local opt = vim.opt
-- completions
opt.completeopt = 'menu,menuone,noselect'
opt.shortmess:append { s = true, W = true, I = true, c = true }

opt.autowrite = true -- Enable auto write
opt.backspace:append { 'nostop' } -- Don't stop backspace at insert
opt.breakindent = true -- Wrap indent to match  line start
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.cmdheight = 0 -- hide command line unless needed
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.copyindent = true -- Copy the previous indentation on autoindenting
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Enable the use of space in tab
opt.fileencoding = 'utf-8' -- File content encoding for the buffer
opt.fillchars = { eob = ' ' } -- Disable `~` on nonexistent lines
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.history = 100 -- Number of commands to remember in a history table
opt.ignorecase = true -- Case insensitive searching
opt.ignorecase = true -- Ignore case/
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.infercase = true -- Infer cases in keyword completion
opt.laststatus = 3 -- globalstatus
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.preserveindent = true -- Preserve indent structure as much as possible
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.showtabline = 2 -- always display tabline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen' -- Maintain code view when splitting
opt.splitright = true -- Put new windows right of current
opt.swapfile = false
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 500
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.viewoptions:remove 'curdir' -- disable saving current directory with views
opt.virtualedit = 'block' -- allow going past end of line in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.writebackup = false -- Disable making a backup before overwriting a file

--
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
log( 'vim options set')
end

M.setup = setup

return M
