
set modelines=1

" Folding {{{
"
set foldmethod=marker
"
" " Toggle folding
"
" nnoremap \ za
" vnoremap \ za
"
" }}}
" basic options {{{

scriptencoding utf-8            " explicitly set encoding to utf-8
set encoding=utf-8
set autoread                    " read when a file is changed from the outside
set autowriteall                " auto write file
set ls=2                        " status line always visible
set visualbell                  " turn on the visual bell
set cursorline                  " highlight the line under the cursor
set fillchars+=vert:│           " better looking for windows separator
set ttyfast                     " better screen redraw
set title                       " set the terminal title to the current file
set showcmd                     " shows partial commands
set hidden                      " hide the inactive buffers
set ruler                       " sets a permanent rule
set lazyredraw                  " only redraws if it is needed
set t_ut=                       " try to fix redraw under tmux
set autoread                    " update a open file edited outside of Vim
set ttimeoutlen=0               " toggle between modes almost instantly
set backspace=indent,eol,start  " defines the backspace key behavior
set virtualedit=all             " to edit where there is no actual character
set more                        " to show pages using `more` in command
set scrolloff=10                " screen lines to keep above and below the cursor
set hidden                      " allow changing buffer without saving it first
set number                      " display line numbers
set relativenumber              " display rel number
set numberwidth=3               " gutter col width
" }}}
source ~/.vim/setup/functions.vim
" Searching {{{

set magic                       " make regex a little easier to type
set incsearch                   " incremental searching
set showmatch                   " show pairs match
set hlsearch                    " highlight search results
" case insensitive search
set smartcase                   " smart case ignore
set ignorecase                  " ignore case letters

" }}}
" History and permanent undo levels {{{

set history=1000
set undofile
set undoreload=1000

" }}}
" Backups {{{

set backup
set noswapfile
set backupdir=$HOME/.vim/tmp/backup/
set undodir=$HOME/.vim/tmp/undo/
set directory=$HOME/.vim/tmp/swap/
set viminfo+=n$HOME/.vim/tmp/viminfo

" make this dirs if no exists previously
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&directory)

" }}}
" Wildmenu {{{

set wildmenu                        " Command line autocompletion
set wildmode=list:longest,full      " Shows all the options

set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.jar                            " java archives
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.stats                          " Pylint stats

" }}}
" Tabs, space and indents{{{

set expandtab                  " spaces instead of tabs
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
"
" set formatoptions=qrn1ct
"}}}
" Text display settings and wrapping {{{
set linebreak
set nowrap

set textwidth=80
set colorcolumn=81
" }}}
" Colorscheme {{{
syntax enable                  " enable the syntax highlight
set background=dark           " set a dark background
set t_Co=256                   " 256 colors for the terminal
"let g:seoul256_background = 239

" colorscheme seoul256-light
colorscheme seoul256
" " }}}
" Statusline {{{

set noshowmode
 let g:lightline = {
       \ 'colorscheme': 'wombat',
      \ }

let g:tmuxline_powerline_separators = 0

" }}}
" Unite. The interface to rule almost everything {{{
    " https://github.com/joedicastro/dotfiles/tree/master/vim
"I set Unite following two different ways.
"On one hand I use it to access Unite sources via mappings with the <Leader> key
", and secondly calling Unite menus through <LocalLeader> key mappings.

" cm <c-o> <Plug>(unite_cmdmatch_complete)vim

source ~/.vim/setup/unite.vim
source ~/.vim/setup/leader-mappings.vim " <comma>
source ~/.vim/setup/menus.vim           " <space>
source ~/.vim/setup/menu-files.vim      " master menu = <space> + u
" }}}
" display unprintable chars {{{

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" }}}
 " Quick saving {{{
nmap <silent> <Leader>w :update<CR>

" }}}

" Sessions }}}
" help: Prossession

" let g:loaded_prosession = 1 "  default
" let g:prosession_dir = '~/.vim/session/' " default
" let g:prosession_on_startup = 1 "  default: auto load on startup
" let g:prosession_default_session = 0 " NOPE! every  project default session
let g:prosession_per_branch = 1 " YEP!
" let g:prosession_branch_cmd = 'git rev-parse --abbrev-ref HEAD 2>/dev/null'
" let g:prosession_tmux_title = 1 " YEP!

" }}}

"autocmd VimEnter * if !argc() | VimFilerExplorer -no-quit -project -status -find | endif
" vim:foldmethod=marker:foldlevel=0
