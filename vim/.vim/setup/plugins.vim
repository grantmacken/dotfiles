filetype off

let g:bundles_path = g:vim_home . 'plugged/'


" Plugs 
call plug#begin(g:bundles_path)

call plug#begin('~/.vim/plugged')
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Unite plugin that provides command line completition
Plug  'joedicastro/unite-cmdmatch'

" Fuzzy search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler'
" Plug 'Shougo/unite-session'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/junkfile.vim'
Plug 'Shougo/unite-outline'

Plug 'osyo-manga/unite-filetype'
Plug 'osyo-manga/unite-fold'
Plug 'osyo-manga/unite-quickfix'

Plug 'dbakker/vim-projectroot'

Plug 'thinca/vim-unite-history'
Plug 'tsukkee/unite-help'
Plug 'ujihisa/unite-locate'
Plug 'tacroe/unite-mark'

" Unite plugin that provides spell suggestions
Plug 'kopischke/unite-spell-suggest'

Plug 'ujihisa/unite-colorscheme'

"Plug 'rking/ag.vim'

" Code completion
"Plug 'Shougo/neocomplete.vim'
"Plug 'wellle/tmux-complete.vim'

" Comments

"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

" Git
"
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
"Plug 'SirVer/ultisnips'

" Motions
"Plug 'Lokaltog/vim-easymotion'

" sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession' " each git project has associated vim session
"
"
" Text Objects
"Plug 'tpope/vim-surround'
"Plug 'tpope/vim-repeat'
"Plug 'terryma/vim-expand-region'

" Tags

" tmux
" Plug 'wincent/terminus'
Plug 'tmux-plugins/vim-tmux'               " vim plugin for .tmux.conf
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Color themems
Plug 'junegunn/seoul256.vim'

" Misc
"Plug 'kana/vim-submode'
"Plug 'ton/vim-bufsurf'
"Plug 'terryma/vim-smooth-scroll'
"Plug 'terryma/vim-multiple-cursors'

" a better looking status line {{{
"Plug 'bling/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" }}}

call plug#end()


filetype plugin indent on
syntax enable


