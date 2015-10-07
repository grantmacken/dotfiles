filetype off

" Plugs 
call plug#begin('~/.vim/plugged')
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/tabpagebuffer.vim'
Plug 'itchyny/vim-cursorword'
Plug 'itchyny/vim-gitbranch'
Plug 'kshenoy/vim-signature'
Plug 'Yggdroot/indentLine'
"Plug 'Yggdroot/file-line'
Plug 't9md/vim-choosewin'  " simplifies window navigation like tmux

" Fuzzy search
Plug 'junegunn/fzf',{ 'dir': '~/.fzf', 'do': 'yes \| ./install' } 
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimfiler'
" Plug 'Shougo/unite-session'
" Unite sources {{{

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
Plug 'kopischke/unite-spell-suggest'
Plug 'ujihisa/unite-colorscheme'

" }}}
" Unite plugin that provides command line completition
Plug  'joedicastro/unite-cmdmatch' 
" templates
"  https://github.com/noahfrederick/vim-skeletonlug
Plug 'noahfrederick/vim-skeleton'  
"Plug 'rking/ag.vim'

" Code completion                
"Plug 'Shougo/neocomplete.vim'
"Plug 'wellle/tmux-complete.vim'

" Comments

"Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'

" Git, Github and Gists
"
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/vim-gista'
Plug 'tyru/open-browser.vim'
" ~/.vim/setup/plugins.vim Snippets
"Plug 'SirVer/ultisnips'

" Motions
"Plug 'Lokaltog/vim-easymotion'
"
"
" writing
"  try to rely on builtin tim/pope markdown
"  use ftdetect vim/.vim/ftdetect/markdown.vim
"  http://www.swamphogg.com/2015/vim-setup/
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
" Plug 'vim-pandoc/vim-pandoc-after'
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" sessions
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession' " each git project has associated vim session
"
"
" Text Objects
Plug 'tpope/vim-surround'
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

" a better looking status line 
Plug 'bling/vim-airline'
"Plug 'itchyny/lightline.vim'
Plug 'edkolev/tmuxline.vim'
" 



call plug#end()





