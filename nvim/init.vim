
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
if ! isdirectory(expand($VARPATH))
    " Create missing dirs i.e. cache/{undo,backup}
    call mkdir(expand('$VARPATH/undo'), 'p')
    call mkdir(expand('$VARPATH/backup'))
endif	
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
" Disable default plugins "{{{

" }}}
" <leader>vr :sp $MYVIMRC<cr> "Split edit your vimrc.
" <leader>so :source $MYVIMRC<cr> "Source (reload) your vimrc.
" Add In Plugings {{{
call plug#begin(expand('$VIMPATH/plugged'))
Plug 'airblade/vim-rooter'
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'	
Plug 'janko-m/vim-test'
Plug 'simnalamburt/vim-mundo'
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gita'
Plug 'tpope/vim-commentary'
Plug 'itchyny/vim-gitbranch'
Plug 'christoomey/vim-tmux-navigator'
Plug 'noahfrederick/vim-skeleton'
Plug 'sickill/vim-pasta'
Plug 'christoomey/vim-tmux-runner'
" Visual
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'shinchu/lightline-seoul256.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
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
"===============================================================================
" General Settings
" nvim Notes {{{ 
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
"===============================================================================
syntax on
set modelines=1
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-45841328i
set autowriteall  " auto write file
" Colorscheme {{{
let g:seoul256_background = 234
colorscheme seoul256
set background=dark
" }}}
"===============================================================================
" PLUGGED 
"==============================================================================
" Use deoplete {{{
let g:deoplete#enable_at_startup = 1
" }}}
" Use lightline {{{ 
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
" last line is modeline
" vim:foldmethod=marker:foldlevel=0
