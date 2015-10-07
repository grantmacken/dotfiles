
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
" Open new split panes to right and bottom, which feels more natural
set splitbelow                  " open new split panes to right and bottom
set splitright
if has('mouse')
    set mouse=a
    "set ttymouse=xterm2
endif
set clipboard=unnamed
" set clipboard^=unnamedplus
" set paste
" set go+=a
" }}}
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
set undolevels=5000

" }}}
" Backups {{{
" http://stackoverflow.com/a/15317146

set backup                        " use backups
set writebackup
set backupdir=$HOME/.vim/tmp/backup//  " 

set noswapfile
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

set noexpandtab                " tabs instead of spaces to indent code
set smarttab                   " respect options below
set tabstop=4                  " a tab = four spaces
set shiftwidth=4               " number of spaces for auto-indent
set softtabstop=4              " a soft-tab of four spaces
set autoindent                 " set on the auto-indent
set shiftround                 " round indent to multiple of shiftwidth
"
"
"}}}
" Spelling {{{
" setlocal spell spelllang=en_nz
" }}}
" Text display settings and wrapping {{{
set linebreak
set nowrap

set textwidth=80
set colorcolumn=81
" }}}


" }}}
" display unprintable chars {{{

set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:␣
set showbreak=↪

" }}}

"autocmd VimEnter * if !argc() | VimFilerExplorer -no-quit -project -status -find | endif
" vim:foldmethod=marker:foldlevel=0
