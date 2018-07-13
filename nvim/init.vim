scriptencoding utf-8
" XDG Paths {{{
if exists('$XDG_CONFIG_HOME')
  let $VIMPATH=expand('$XDG_CONFIG_HOME/nvim')
  let $CACHEPATH=expand('$XDG_CACHE_HOME/nvim')
  let $DATAPATH=expand('$XDG_DATA_HOME/nvim/site')
else
  let $VIMPATH=expand('$HOME/.config/nvim')
  let $CACHEPATH=expand('$HOME/.cache/nvim')
  let $DATAPATH=expand('$HOME/.local/share/nvim/site')
endif

let $PROJECTS_PATH=expand( $HOME . '/projects/grantmacken' )

" }}}
" Global Mappings "{{{
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
" pyenv activate neovim3
" pip install neovim jedi pylint mistune psutil setproctitle
" pip install python-language-server
" pip install --python-language-server
" Python based linters
" pycodestyle pyflakes flake8 vim-vint proselint yamllint
" https://github.com/mhinz/neovim-remote
let g:python_host_prog = expand('$HOME/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog =  expand('$HOME/.pyenv/versions/neovim3/bin/python')
"
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader      = ' '
let g:maplocalleader = ' '
" let g:maplocalleader=','
" " Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
" }}}
" Add In Plugins {{{
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" augroup init
"   autocmd!
"   autocmd SessionLoadPost * echom 'session loaded'
" augroup END

call plug#begin( expand( $DATAPATH . '/plugged'))
" File_And_Project_Management {{{
" ---------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tweekmonster/fzf-filemru'
"GF: site/after/plugin/fzf.vim
" Plug 'dominickng/fzf-session.vim'
Plug 'justinmk/vim-dirvish' 
"URL: https://github.com/justinmk/vim-dirvish/blob/master/doc/dirvish.txt
"GF: site/after/ftplugin/dirvish.vim
Plug 'fsharpasharp/vim-dirvinist'
" https://www.youtube.com/watch?v=Av2pDIY7nRY
Plug 'mhinz/vim-startify'
"GF: site/after/plugin/startify.vim
"@ sessions
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-eunuch'     " https://github.com/tpope/vim-eunuch
Plug 'tpope/vim-dotenv' " https://github.com/tpope/vim-dotenv

" Plug 'tpope/vim-dispatch'
" Plug 'radenling/vim-dispatch-neovim'

Plug 'arithran/vim-delete-hidden-buffers'
" Plug 'mhinz/vim-grepper'
" let g:grepper = {}
" let g:grepper.tools = ['grep', 'git', 'rg']

" Plug 'skwp/greplace.vim' "https://github.com/skwp/greplace.vim/blob/master/doc/greplace.txt

" Plug 'moll/vim-bbye'
" Plug 'rbgrouleff/bclose.vim' " delete buffer without closing window
" :DeleteHiddenBuffers
" Plug 'airblade/vim-rooter'
" let g:rooter_patterns = ['.projections.json', '.git/']

Plug 'tweekmonster/nvim-api-viewer'
" }}}
" ---------------------------
" neovim terminal
" Plug 'hkupty/nvimux'
" git gists and gith0;29M0;29mub
" Plug 'lambdalisue/gina.vim', {'on': ['Gina']}
" Plug 'lambdalisue/vim-gista', {'on': ['Gista']}
" Plug 'lambdalisue/lista.nvim'
Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
" Plugt'lambdalisue/vim-gita'
" Code Lint Compile Build Test
" ----------------------------
Plug 'w0rp/ale'
"GF: site/after/plugin/ale.vim
Plug 'sbdchd/neoformat'
"GF: site/after/plugin/neoformat.vim
" Plug 'pgdouyon/vim-accio' "@see https://github.com/pgdouyon/vim-accio
"GF: nvim/site/after/plugin/accio.vim
Plug 'romainl/vim-qlist'
" https://github.com/romainl/vim-qlist/blob/master/doc/qlist.txt
" TODO use for filetype buffer xQuery lua
" |'include'|     tells Vim how to find include directives in your files
" |'define'|      tells Vim how to find definitions in your files
"  
" |'includeexpr'| can be useful to clean up your include directives
"               | should be able to do for lua path directives
" |'suffixesadd'| helps Vim infer `foo.js` from `foo`
" |'path'| tells Vim where to look for include files
" Plug 'skywind3000/asyncrun.vim'
Plug 'kassio/neoterm'
" Plug 'janko-m/vim-test'
" Auto Completions and Snippets.
" ------------------------------
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete.vim', { 'branch': 'TextChangedP' }
Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp', { 'branch': 'dev' }
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim' " BUFFER source
Plug 'Shougo/neco-vim'          " VIM autocompletions https://github.com/Shougo/neco-syntax
Plug 'prabirshrestha/asyncomplete-necovim.vim'  " VIM source via neco-vim
Plug 'Shougo/neco-syntax'       " SYNTAX https://github.com/Shougo/neco-syntax
Plug 'prabirshrestha/asyncomplete-necosyntax.vim' " SYNTAX source via neco-syntax
Plug 'wellle/tmux-complete.vim'
" Plug 'prabirshrestha/asyncomplete-emoji.vim'
" Plug 'yami-beta/asyncomplete-omni.vim'
" Plug 'prabirshrestha/asyncomplete-tags.vim' " https://github.com/prabirshrestha/asyncomplete-tags.vim
" let g:python_support_python2_require = 0
" Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips'     " https://github.com/SirVer/ultisnips
"GF: site/after/plugin/ultisips.vim
Plug 'honza/vim-snippets'
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
" Plug 'Shougo/denite.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/echodoc'  " recomended plugin .. to look at function auguments
" Plug 'autozimu/LanguageClient-neovim', { 'do': function('DoRemote')}
" deoplete sources generic
" Plug 'Shougo/context_filetype.vim'
" Plug 'Shougo/neoinclude.vim'  " FILE deoplete file/include source and extends tag source
" Plug 'fszymanski/deoplete-emoji' " EMOJI
" Plug 'ujihisa/neco-look'       " SPELL deoplete spelling source ... word completion with 'look' command ref man look
" deoplete sources filetpes
" Plug 'zchee/deoplete-jedi'      " PYTHON autocompletions https://github.com/Shougo/neco-syntax
" Plug 'mhartington/nvim-typescript', { 'do': function('DoRemote')} " TYPESCRIPT https://github.com/mhartington/nvim-typescript
" Plug 'fszymanski/deoplete-emoji' "EMOJI
Plug 'Konfekt/FastFold'           "recomended Shougo plugin
" Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" Plug 'simnalamburt/vim-mundo'   " history
Plug 'szw/vim-maximizer'     " zoom vim window
" Editing Code manipulation
" Plug 'junegunn/rainbow_parentheses.vim' " https://github.com/junegunn/rainbow_parentheses.vim
" let g:rainbow#max_level = 16
" let g:rainbow#pairs = [['(', ')'], ['[', ']'], [ '{' , '}' ], [ ':', ':' ] ]
" Activation based on file type
" augroup rainbow_lisp
"   autocmd!
"   autocmd FileType xquery RainbowParentheses
" augroup END
" " List of colors that you do not want. ANSI code or #RRGGBB
" let g:rainbow#blacklist = [233, 234]
Plug 'whatyouhide/vim-lengthmatters'
Plug 'junegunn/vim-peekaboo' "https://github.com/junegunn/vim-peekaboo
Plug 'bradford-smith94/quick-scope' 
" https://github.com/bradford-smith94/quick-scope
"GF: site/after/plugin/quickscope.vim
Plug 'junegunn/vim-easy-align' " https://github.com/junegunn/vim-easy-align
Plug 'machakann/vim-highlightedyank' " highligh yank text
" Plug 'bfredl/nvim-miniyank'       " https://github.com/bfredl/nvim-miniyank
" Plug 'cohama/lexima.vim'
" Plug 'Raimondi/delimitMate' " https://github.com/Raimondi/delimitMate
Plug 'tpope/vim-commentary'  , { 'on': ['<Plug>Commentary', '<Plug>CommentaryLine'] }
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
"Plug 'cazador481/fakeclip.neovim'
" tags
"Plug 'ludovicchabant/vim-gutentags'
" Visual
" Plug 'ryanoasis/vim-devicons'
" Plug 'itchyny/lightline.vim' " will call gita for git updates
" Plug 'cocopon/lightline-hybrid.vim'
" Plug 'bling/vim-bufferline'  TODO
"Plug 'shinchu/lightline-seoul256.vim' " now in lightline colorschemes
" Plug 'edkolev/tmuxline.vim'
" Plug 'itchyny/vim-gitbranch'
" writing
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim
" Plug 'ron89/thesaurus_query.vim' TODO https://github.com/Ron89/thesaurus_query.vim
" language-specific plugins
Plug 'vitalk/vim-shebang' "https://github.com/vitalk/vim-shebang
" https://github.com/vitalk/vim-fancy
" https://github.com/vitalk/vim-simple-todo
Plug 'othree/yajs.vim', { 'for': 'javascript' }           " JAVASCRPT SYNTAX object/method data comes from Mozilla's WebIDL
Plug 'HerringtonDarkholme/yats.vim',{'for': 'typescript'} " TYPESCRIPT
Plug 'gavocanov/vim-js-indent' ,{'for': 'javascript'}     " JAVASCRIPT INDENT
Plug 'elzr/vim-json', { 'for': 'json' } "                  JSON support
Plug 'ap/vim-css-color', { 'for': 'css' }       "   CSS set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } "   CSS3 syntax support
Plug 'othree/html5.vim'                         "   HTML 5 with  WAI-ARIA attribute support
Plug 'othree/xml.vim'                           "   XML tags while you type
Plug 'tbastos/vim-lua', { 'for': 'lua' } "          LUA syntax and indentation support
Plug 'chr4/nginx.vim'                           "   NGINX with embeded lua block highlight
" Plug 'othree/nginx-contrib-vim', {'for': 'nginx'} " NGINX
Plug 'ledger/vim-ledger', {'for': 'ledger'}                           " lEDGER
Plug 'junegunn/vader.vim'                         " VIM    testing vim plugings -- use for syntax
" Plug 'heavenshell/vim-jsdoc' "  jsdocs  https://github.com/heavenshell/vim-jsdoc
" Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " setup tern
" Plug 'carlitux/deoplete-ternjs' " COMPLETION: deoplete tern as recomended by Shougo
" Plug 'othree/jspc.vim' ... COMPLETION:  function param completion
" Plug 'tmux-plugins/vim-tmux'
" Plug 'othree/javascript-libraries-syntax.vim'
" Plug 'othree/es.next.syntax.vim'a
" JavaScript:  https://davidosomething.com/blog/vim-for-javascript/
" VIM:
" XQUERY/
"Plug 'vim-scripts/XQuery-indentomnicompleteftplugin' " might have to install manually
call plug#end()

"}}}
"Themes and Colorscheme {{{
Plug 'junegunn/seoul256.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'trevordmiller/nova-vim'
Plug 'mhinz/vim-janah'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
" let g:airline#extensions#ale#enabled = 1
call plug#end()
" syntax enable
set termguicolors
set background=dark
"   Range:   233 (darkest) ~ 239 (lightest
"   Default: 237
let g:seoul256_background = 238
let g:seoul256_srgb = 1
colorscheme seoul256
" colorscheme koehler
highlight Pmenu     guifg=#d7d7af guibg=#585858
highlight PmenuSel  guifg=#4e4e4e  guibg=#d7d7af
" itchyny
" set background=dark
" let g:airline_theme='zenburn
" overide
" colorscheme seoul256-light
highlight VertSplit guifg=#585858 guibg=#585858


" set background=dark
" let g:airline_theme='zenburn
" overide
" colorscheme seoul256-light
" let bf = g:seoul256_current_bg
" let fg = g:seoul256_current_fg
" highlight PmenuSel    ctermfg=187 ctermbg=95
" highlight PmenuSel    guifg=darkblue guibg=95
" highlight Pmenu ctermfg=187  ctermbg=239
" highlight VertSplit ctermfg=239 ctermbg=239

" colorscheme nova
" i
" }}}
" BASIC SETTINGS {{{
" ==================

augroup vimrc
  autocmd!
augroup END

" Editor UI Appearance {{{
" MOUSE
set mouse=a
" set mousemodel=popup_setpos
" window  settings {{{
set notitle             " No need for a title
set noequalalways       " Don't resize windows on split or close
set winwidth=30         " Minimum width for current window
set winheight=1         " Minimum height for current window
set splitbelow
set splitright
"}}}

set helpheight=12       " Minimum help window height
" panes: gutter, tabline, commandline , help {{{
" left gutter
set number              " Show line numbers
set numberwidth=3
set relativenumber      " Use relative instead of absolute line numbers

" Bottom Command
" ----------------
set noshowmode          " Don't show mode in cmd window
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines
set inccommand=nosplit  " Neovim highlight
set gdefault            " Force Vim to always do global substitutions.

" set noshowcmd           " Don't show command in status line
" set shortmess+=A
set noshowcmd
" set noruler             " Disable default status ruler
set ruler
"set rulerformat=%15(%c%V\ %p%%%)
" set ruler
let &rulerformat=my#statusline#rulerFormat()

" statusline
" -----------
set laststatus=1
set statusline=%!my#statusline#statusline()
" " messages

" Top  tabline
" ----------------
set showtabline=1
set tabline=%!my#statusline#tabline()
" set tabpagemax=30     " Already set to 50 in neovim  Maximum number of tab pages
" }}}
" main buffer window pane
set colorcolumn=120     " Highlight the 120 th character limit
set synmaxcol=200
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
set signcolumn=yes    " keep signcolumn open
" split dividers
" set fillchars=""
" hi VertSplit guibg=#556873 ctermbg=2
" Complete Options
" -----------------
" :h complete
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" bu

" Spelling
" --------
" let g:spell_add=expand($CACHEPATH . '/spell/en.utf-8.add')
" exec "set spellfile=" . g:spell_add

" SEARCH
" set wildmode=longest,full
" set wildignorecase
"}}}
" Typography: Widths, Tabs, Indents Folds{{{
set textwidth=120   " Text width maximum 120 chars before wrapping
" @see lengthmatters
set expandtab       " expand tabs to spaces except for Make see runtime
set softtabstop=2   " While performing editing operations
" /usr/share/nvim/runtime/ftplugin/make.vim
" set nosmarttab
set tabstop=2       " The number of spaces a tab is
set shiftwidth=2    " Number of spaces to use in auto(indent)
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
" folds
set foldmethod=marker
set foldnestmax=1
" Changing characters to fill special ui elements
set breakindent
set showbreak=↪
set list                " Show hidden characters
" set fillchars=vert:│,fold:─
" nvim defaults set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,nbsp:.,trail:·
" }}}
" File and Project Management {{{
" grep {{{

set grepprg=rg\ --vimgrep
"   "                 |
"   "                 `------------ Format results for Vim, include multiple matches per line
set grepformat=%f:%l:%c:%m

" }}}
" sessions {{{
" " What not to save in sessions:
" set sessionoptions-=options  neovim default
set sessionoptions-=globals
set sessionoptions-=help
" http://vim.wikia.com/wiki/Quick_tips_for_using_tab_pages
" set sessionoptions=blank,buffers,curdirs,tabpages,winsize
" }}}

let g:loaded_netrwPlugin = 1
set hidden
set noswapfile
set nobackup
set undofile
" set undodir=expand($CACHEPATH . '/undo') nvim set by default
set undolevels=5000
set undoreload=10000
augroup vimrc
  autocmd BufWritePre /tmp/* setlocal noundofile
augroup END
" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-45841328i
" set autowriteall  "Save buffer automatically when changing files
set autoread      "Always reload buffer when external changes detected
" https://bluz71.github.io/2017/05/15/vim-tips-tricks.html
"augroup autoSaveAndRead
" autocmd!
"  autocmd TextChanged,InsertLeave,FocusLost * silent! wall
"  autocmd CursorHold * silent! checktime
"augroup END
" Save everything here
" ls  $HOME/.cache/nvim/session/
" rm  $HOME/.cache/nvim/session/*
" Project and File Management Plugins
" - eunuch
" - projectionist
" - startify
" - fzf
" }}}
" }}}
" Auto Completions {{{
" Popup Menu Styling
" set shortmess+=c
" set shortmess=aoOTI     " Shorten messages and don't show intro
set shortmess+=c        " https://github.com/roxma/nvim-completion-manager
" ------------------
set pumheight=20        " Pop-up menu's line height
set previewheight=2     " Completion preview height

"complete options
" :h complet
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" below are async defualt
set completeopt-=longest
set completeopt+=menuone
set completeopt-=menu
set completeopt+=noinsert       " auto select feature like neocomplete
" set completeopt+=noselect
set completeopt-=preview
" set completeopt+=longest
" set completeopt+=preview
" }}}
" Terminal {{{
" tnoremap <expr> <A-r> '<C-\><C-n>'.nr2char(getchar()).'pi'
set switchbuf+=useopen
" map esc in term
" }}}
" Functions {{{
"
function! StylePreviewWindow()
  if &previewwindow
    setlocal nowrap
    setlocal norelativenumber
    setlocal nonumber
  endif
endfunction
" }}}
" Commands {{{
" command! -nargs=* Make Accio <args>
"@see nvim/site/lua/my/jobs.lua 
command! -nargs=0 Prove lua require('my.jobs').qfJobs('prove')
command! -nargs=0 Qnext lua require('my.qf').rotateNext()
command! -nargs=0 Qprev lua require('my.qf').rotatePrev()
command! -nargs=0 Qtoggle lua require('my.qf').toggle()

"GF: site/lua/my/qf.lua
" nnoremap <silent> <leader>l :call my#qf#toggle("Quickfix List", 'c')<CR>
" }}}
" Mappings  {{{
" {{{ Use Alt {1,2 ... } to go to tab by number
" noremap <leader>1 1gt
noremap <A-1> 1gt
noremap <A-2> 2gt
noremap <A-3> 3gt
noremap <A-4> 4gt
noremap <A-5> 5gt
noremap <A-6> 6gt
noremap <A-7> 7gt
noremap <A-8> 8gt
noremap <A-9> 9gt
noremap <A-0> :tablast<cr>
" }}}
" {{{ Use Alt {h,j.k,l} to navigate windows
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"}}}
" QUICKFIX {{{
nnoremap <silent> [q :Qnext<CR>
nnoremap <silent> ]q :Qprev<CR>
nnoremap <silent> <leader>q :Qtoggle<CR>
nnoremap <F9> :Prove<CR>
" }}}
" LEADER MAPPINGS - my leader is the space bar {{{
nnoremap <silent> <leader>d :Dirvish %:p:h<CR>
nnoremap <silent> <leader>tb :tabnew<space>
" }}}
" {{{ INSERT MAPPINGS
" tab completion
" @see nvim/site/after/plugin/asyncomplete.vim
" NOTE: ultisnips works with asyncomplete
" after <ENTER>
" <CNTRL><e> will expand
" NOTE
" }}}: 
" PLUGIN MAPPINGS {{{
" https://github.com/junegunn/vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign
" autocmd! InsertChange,TextChanged *.html update | :Accio [ "tidy", "xmlwf", "xmllint" ]
" <F8> sav and run checker
"  autocmd BufWrite <buffer> Accio ["xqm"]

" vim-commentary maps, since it is loaded lazily
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
" }}}
" TERMINAL MAPPINGS {{{
tnoremap <Esc> <C-\><C-n>
" when in terminal go back to previous window
" tnoremap <F12> <C-\><C-n><C-w><C-p>
" set ttimeoutlen=1
" term colors
" hi! link TermCursor Cursor
" hi! TermCursorNC ctermfg=15 ctermfg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" https://neovim.io/doc/user/options.html#%27term%27
" https://neovim.io/doc/user/autocmd.html#TermClose
" https://neovim.io/doc/user/nvim_terminal_emulator.html#nvim-terminal-emulator
" TermChanged, TermClose, TermResponse
" }}}

"}}}
" {{{ Augroups [ myQuickfix , init ]
augroup myQuickfix
  autocmd!
  "@see site/lua/my/qf.lua
  autocmd QuitPre * lua require('my.qf').close()
  " autocmd QuickFixCmdPre caddexpr lua require('my.qf').onCmdPre()
  " before a quicklist command is run
  " autocmd QuickFixCmdPost caddexpr lua require('my.qf').onCmdPost()
  " after a quicklist command is run
  "GF: nvim/site/autoload/my/qf.vim
  " our shell commands 'make' etc run from project root
  " ---------------------------------------------------
  " When the quickfix window has been filled,
  " two autocommand events are triggered
  " First the 'filetype' option is set to 'qf' triggers filetype event
  "GF: nvim/site/after/ftplugin/qf.vim
  "Then the BufReadPost event is triggered,
  " using 'quickfix' for the buffer name
  " autocmd BufReadPost quickfix  lua require('my.qf').onFilled()
  autocmd BufWinEnter quickfix  lua require('my.qf').onEntered()
  "GF: nvim/site/autoload/my/qf.vim
augroup END

augroup myTerm
  autocmd!
   autocmd TermOpen * lua require('my.term').onOpen()
  " autocmd TermChanged * lua require('my.term').onChanged()
  " autocmd TermClose * lua require('my.term').onClose()
  " autocmd TermResponse * lua require('my.term').onResponse()
augroup END

augroup myInit
  autocmd!
  autocmd VimEnter * lua require('my.signs').define()
  " autocmd CursorHold  term://* lua require('my.util').echom(' - Buffer Cursor Hold  ')
  autocmd BufWritePost $MYVIMRC nested source $MYVIMR
  " autocmd BufEnter * :syntax sync fromstart
  " NOTE: filetype
  " detection -- '/usr/share/nvim/runtime/filetype.vim'
  " make recognizes  mk extension
  " xquery recognizes xql xqm xq
  " autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

  autocmd BufNewFile,BufRead *.conf set filetype=nginx "add nginx filetype for any conf extension
  autocmd BufNewFile,BufRead *.snippets set filetype=snippets "add new snippets filetpe
  autocmd BufNewFile,BufRead *.t set filetype=prove "  instead of perl
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufWinEnter * call StylePreviewWindow()
  "@see nvim/site/autoload/my/asyncomplete.vim
  autocmd User asyncomplete_setup call my#asyncomplete#setup()
  " ---------------------------------------------------
  " Projections
  " -----------
  " ProjectionistDetect    - tries to detect projection for current file in buffer
  "                        - if detected sets
  "                            - b:projectionist_file
  "                            - b:projectionist  (object)
  " @see projectionist auto commands
  " triggered when searching for projections
  " autocmd User ProjectionistDetect  lua require('my.project').detect()
  "  triggered when projections found:
  "@see nvim/site/lua/my/project.lua
   autocmd User ProjectionistActivate lua require('my.project').activate()
  " ---------------------------------------------------
augroup END

" }}}
