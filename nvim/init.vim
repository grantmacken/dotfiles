
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
Plug 'benekastah/neomake'
Plug 'Shougo/deoplete.nvim'
Plug 'simnalamburt/vim-mundo'
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gita'
" Visual
Plug 'junegunn/seoul256.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
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
"
syntax on

set modelines=1
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-45841328i
set autowriteall  " auto write file
" Colorscheme {{{
let g:seoul256_background = 234
colorscheme seoul256
set background=dark
" }}}

" last line is modeline
" vim:foldmethod=marker:foldlevel=0
