let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" Respect XDG {{{
if exists("$XDG_CONFIG_HOME")
	let $VIMPATH=expand('$XDG_CONFIG_HOME/nvim')
	let $VARPATH=expand('$XDG_CACHE_HOME/nvim')
else                                                                     
	let $VIMPATH=expand('$HOME/.config/nvim')
	let $VARPATH=expand('$HOME/.cache/nvim')
endif
" }}}
" Ensure cache directory "{{{
silent! call MakeDirIfNoExists('$VARPATH/undo')
silent! call MakeDirIfNoExists('$VARPATH/backup')
silent! call MakeDirIfNoExists('$VARPATH/session')
silent! call MakeDirIfNoExists('$VARPATH/skeleton')

function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction

" }}}
" Global Mappings "{{{
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader="\<Space>"
let g:maplocalleader=','

" Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
"
" }}}
" My autocmd block - Clear vimrc group's autocmds if reloading {{{
augroup vimrc
	autocmd!
augroup END
" }}}
" Add In Plugings {{{
call plug#begin(expand('$VIMPATH/plugged'))
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'	
Plug 'janko-m/vim-test'
Plug 'simnalamburt/vim-mundo'
Plug 'noahfrederick/vim-skeleton'
Plug 'christoomey/vim-tmux-runner'
" git gists and github
Plug 'airblade/vim-rooter'
Plug 'itchyny/vim-gitbranch'
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gita'
Plug 'airblade/vim-gitgutter'

" edit
Plug 'tpope/vim-commentary', { 'on': '<Plug>Commentary' }
Plug 'sickill/vim-pasta'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'cazador481/fakeclip.neovim'
" snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Visual
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'shinchu/lightline-seoul256.vim'
Plug 'edkolev/tmuxline.vim'
" writing
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim
" sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession' " each git project has associated vim session
" language-specific plugins
Plug 'elzr/vim-json', { 'for': 'json' } " JSON support
Plug 'ap/vim-css-color', { 'for': ['css','stylus','scss'] } " set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } " CSS3 syntax support
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
call plug#end()
"}}}
" General Settings
" vim Notes {{{ 
" 'autoindent' is set by default
" 'autoread' is set by default
" 'backspace' defaults to "indent,eol,start"
" 'complete' doesn't include "i"
" 'display' defaults to "lastline"
" 'encoding' defaults to "utf-8"
" 'formatoptions' defaults to "tcqj"
" 'history' defaults to 10000 (the maximum)
" 'hlsearch' is set by default
" 'incsearch' is set by default
" 'langnoremap' is set by default
" 'laststatus' defaults to 2 (statusline is always shown)
" 'listchars' defaults to "tab:> ,trail:-,nbsp:+"
" 'mouse' defaults to "a"
" 'nocompatible' is always set
" 'nrformats' defaults to "hex"
" 'sessionoptions' doesn't include "options"
" 'smarttab' is set by default
" 'tabpagemax' defaults to 50
" 'tags' defaults to "./tags;,tags"
" 'ttyfast' is always set
" 'viminfo' includes "!"
" 'wildmenu' is set by default
" }}}
" General {{{
syntax on
set modeline                 " automatically setting options from modelines
set report=0                 " Don't report on line changes
set noerrorbells             " Don't trigger bell on error
set visualbell t_vb=         " Don't make any faces
set lazyredraw               " don't redraw while in macros
set hidden                   " hide buffers when abandoned instead of unload
set ffs=unix,dos,mac         " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
" set synmaxcol=1000           " Don't syntax highlight long lines
" syntax sync minlines=256     " Update syntax highlighting for more lines
set formatoptions+=1         " Don't break lines after a one-letter word
set formatoptions-=t         " Don't auto-wrap texti
" }}}
" Files and Directories {{{
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-45841328i
set autowriteall  " auto write file
set undofile
set directory=$VARPATH/swap//
set undodir=$VARPATH/undo//
set backupdir=$VARPATH/backup//
set viewdir=$VARPATH/view/
set spellfile=$VIMPATH/spell/en.utf-8.add
set wildmode=list:longest,full
set wildignorecase
" }}}
" Tabs and Indents {{{
set textwidth=80    " Text width maximum chars before wrapping
set noexpandtab     " Don't expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
set shiftwidth=2    " Number of spaces to use in auto(indent)
" }}}
" Time {{{

set timeout ttimeout
set timeoutlen=1000 " Time out on mappings
set ttimeoutlen=50  " Time out on key codes
set updatetime=1000 " Idle time to write swap

" }}}
" Folds {{{
" -----
set foldenable
set foldmethod=syntax
set foldlevelstart=99
set foldtext=FoldText()

" Nicer fold text
" See: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! FoldText()
	let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
	let foldchar = matchstr(&fillchars, 'fold:\zs.')
	let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	let foldtextend = lines_count_text . repeat(foldchar, 8)
	let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
" }}}
" Colorscheme {{{
let g:seoul256_background = 234
colorscheme seoul256
set background=dark
" }}}
" Behavior {{{
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow splitright       " Splits open bottom right
set switchbuf=usetab,split      " Switch buffer behavior
"set backspace=indent,eol,start  "nvim default Intuitive backspacing in insert mode
set diffopt=filler,iwhite       " Diff mode: show fillers, ignore white
set formatprg=par\ -w78         " Using http://www.nicemice.net/par/
set showfulltag                 " Show tag and tidy search in completion
set completeopt=menuone,preview " Show preview and menu even for one item
"set complete=.                  " No wins, buffs, tags, include scanning
set nowrap                      " No wrap by default
" }}}
" Searching {{{
" ---------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchpairs+=<:> " Add HTML brackets to pair matching
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
" set incsearch       " Incremental search
" set hlsearch        " Highlight search results
" 'hlsearch' is set by default
" 'incsearch' is set by default

" }}}
" Editor UI Appearance {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
set pumheight=20        " Pop-up menu's line height
set number              " Show line numbers
set relativenumber      " Use relative instead of absolute line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters

set showtabline=2       " Always show the tabs line
set tabpagemax=30       " Maximum number of tab pages
set winwidth=30         " Minimum width for current window
set winheight=1         " Minimum height for current window
set previewheight=8     " Completion preview height
set helpheight=12       " Minimum help window height

"set display=lastline   "nvim default
set notitle             " No need for a title
set noshowcmd           " Don't show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set noequalalways       " Don't resize windows on split or close
set laststatus=2        " Always show a status line
set colorcolumn=80      " Highlight the 80th character limit

" Changing characters to fill special ui elements
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,nbsp:.,trail:·

" Do not display completion messages
" Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
if has('patch-7.4.314')
	set shortmess+=c
endif

" For snippet_complete marker
if has('conceal') && v:version >= 703
	set conceallevel=2 concealcursor=niv
endif

" }}}
" PLUGGED
" Comments with vim-commentary {{{
" default mappings 
" gcc comment line
" gc comment
" gcu uncomment
" ----------------------------------------------------------------------------
" }}}
" Clipboard with xClip and fakeclip {{{
let g:vim_fakeclip_tmux_plus=1
" }}}
" Fuzzy File Explorer with FZF {{{
" https://github.com/junegunn/fzf/wiki/
" https://github.com/junegunn/fzf.vim
" Default fzf layout
" - down / up / left / right
" - window (nvim only)
"let $FZF_DEFAULT_OPTS .= ' --inline-info'
let g:fzf_layout = { 'down': '~40%' }
" ctrl-[a-z], alt-[a-z], f[1-4], or any single character
let g:fzf_action = {
  \ 'ctrl-m': 'e',
  \ 'ctrl-t': 'tabedit',
  \ 'alt-j':  'botright split',
  \ 'alt-k':  'topleft split',
  \ 'alt-h':  'vertical topleft split',
  \ 'alt-l':  'vertcal botright split' }
"nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>f  :GitFiles<CR>
nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
"command! Plugs call fzf#run({
"  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
"  \ 'options': '--delimiter / --nth -1',
"  \ 'down':    '~40%',
"  \ 'sink':    'Explore'})
" }}}
" Templates with skeleton {{{
let g:skeleton_template_dir = "$VARPATH/templates"

" }}}
" Sessions with obsession and prosession {{{
" What not to save in sessions:
" set sessionoptions-=options  neovim default
set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
let g:prosession_tmux_title = 1
let g:prosession_on_startup = 1
let g:prosession_default_session = 0
let g:prosession_dir = '~/.cache/nvim/session'
" }}}
" Autocompletion with deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}
" Status and Tabbar with lightline {{{ 
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'fileformat', 'fileencoding', 'filetype' ],
      \   ],
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'fileformat', 'fileencoding', 'filetype' ],
      \   ],
      \ },
      \ 'tabline': {
      \   'left': [
      \     [ 'tabs' ],
      \   ],
      \   'right': [
      \     [ 'close' ],
      \     [ 'git_branch', 'git_traffic', 'git_status', 'cwd' ],
      \   ],
      \ },
      \ 'component_visible_condition': {
      \   'lineinfo': '(winwidth(0) >= 70)',
      \ },
      \ 'component_function': {
      \   'git_branch': 'g:lightline.my.git_branch',
      \   'git_traffic': 'g:lightline.my.git_traffic',
      \   'git_status': 'g:lightline.my.git_status',
      \ },
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \}
let g:lightline.my = {}
function! g:lightline.my.git_branch() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('branch') : ''
endfunction " }}}
function! g:lightline.my.git_traffic() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('traffic') : ''
endfunction " }}}
function! g:lightline.my.git_status() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
endfunction " }}}

"}}}
" ==============================================================================
" MAPPED
" ==============================================================================
" Saving files
inoremap <C-s>     <C-O>:update<CR>
nnoremap <C-s>     :update<CR>
nnoremap <leader>s :update<CR>
nnoremap <leader>w :update<CR>
" Quiting
inoremap <C-Q>     <esc>:q<CR>
nnoremap <C-Q>     :q<CR>
vnoremap <C-Q>     <ESC>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q :qa!<CR>
" Moving forward and back with prefixes  '[' ']' {{{
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
nnoremap ]t :tabn<cr>
nnoremap [t :tabp<cr>
" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz
" ----------------------------------------------------------------------------
" <tab> / <s-tab> | Circular windows navigation
" ----------------------------------------------------------------------------
" nnoremap <tab>   <c-w>w
" nnoremap <S-tab> <c-w>W
" }}}
" AUTOCMD {{{
" ============================================================================
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
	augroup END

augroup vimrc
"	autocmd BufWritePost $MYVIMRC nested source $MYVIMR
"	autocmd BufEnter * :syntax sync fromstart
  " Included syntax
  "au FileType,ColorScheme * call <SID>file_type_handler()
  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END
" }}}
" last line is modeline
" vim:foldmethod=marker:foldlevel=0
