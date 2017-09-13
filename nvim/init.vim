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

" }}}
" Global Mappings "{{{
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
" pyenv activate neovim3
" pip install neovim jedi pylint mistune psutil setproctitle
" pip install python-language-server
" Python based linters
" pycodestyle pyflakes flake8 vim-vint proselint yamllint
" https://github.com/mhinz/neovim-remote
" let g:neoterm_automap_keys = ',tt'
let g:python_host_prog = expand('$HOME/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog =  expand('$HOME/.pyenv/versions/neovim3/bin/python')
"
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader      = ' '
let g:maplocalleader = ','
" let g:maplocalleader=','
" " Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
" }}}
" Add In Plugins {{{
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin( expand( $DATAPATH . '/plugged'))
" File_And_Project_Management {{{
" ---------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
Plug 'airblade/vim-rooter'
" }}}
" ---------------------------
" neovim terminal
" Plug 'hkupty/nvimux'
" git gists and github
" Plug 'lambdalisue/vim-gista' " not yet compatible with neomake
" Plug 'lambdalisue/vim-gita', {'on': ['Gita']}
" Plug 'lambdalisue/vim-gista', {'on': ['Gista']}
" Plug 'lambdalisue/lista.nvim'
Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
" Plugt'lambdalisue/vim-gita'
"projectionist#query("framework")
"
" Code Lint Compile Build Test
" ----------------------------
Plug 'w0rp/ale'
let g:airline#extensions#ale#enabled = 1
" navigate between errors
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" use quicklist instead of locallist
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
Plug 'sbdchd/neoformat'
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_align = 1" Enable alignment
let g:neoformat_basic_format_retab = 1" Enable tab to spaces conversion
let g:neoformat_basic_format_trim = 1" Enable trimmming of trailing whitespace
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END


Plug 'pgdouyon/vim-accio' "@see https://github.com/pgdouyon/vim-accio

" Plug 'skywind3000/asyncrun.vim'
"
" Used for Async
" - Check             [ 'format', 'lint' ] ( on buffer text change  )
" - Compile Builds    [ 'compile' ]        ( on save compile )
" - Test              [ 'prove' ]          ( on build run assertion and functional tests )

" Feedback
" - Populating the quickfix list
" - Placing signs on the line of the found error
" - Echoing the error message when the cursor is on an error line.
" @see compiler

Plug 'kassio/neoterm'
" Plug 'janko-m/vim-test'
" Plug 'sbdchd/neoformat'
"
" Auto Completions and Snippets.
" ------------------------------
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/async.vim'
" Plug 'prabirshrestha/vim-lsp', { 'branch': 'dev' }
" Plug 'prabirshrestha/asyncomplete-lsp.vim'
" Plug 'prabirshrestha/asyncomplete-buffer.vim'
" Plug 'prabirshrestha/asyncomplete-emoji.vim'
" Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
" Plug 'prabirshrestha/asyncomplete-necovim.vim'
" Plug 'prabirshrestha/asyncomplete-necosyntax.vim'
" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
" Plug 'yami-beta/asyncomplete-omni.vim'
" Plug 'prabirshrestha/asyncomplete-flow.vim'
" Plug 'prabirshrestha/asyncomplete-tags.vim' " https://github.com/prabirshrestha/asyncomplete-tags.vim
" Plug 'roxma/nvim-completion-manager' " can't handle multiple invim instances
" Plug 'roxma/python-support.nvim'
" let g:python_support_python2_require = 0
" Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
" Plug 'autozimu/LanguageClient-neovim', { 'do': function('DoRemote') }
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'     " https://github.com/SirVer/ultisnips
Plug 'honza/vim-snippets'
" Plug 'Shougo/denite.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/echodoc'  " recomended plugin .. to look at function auguments
" Plug 'autozimu/LanguageClient-neovim', { 'do': function('DoRemote')}
" deoplete sources generic
Plug 'Shougo/neco-syntax'       " SYNTAX https://github.com/Shougo/neco-syntax
Plug 'Shougo/context_filetype.vim'
" Plug 'Shougo/neoinclude.vim'  " FILE deoplete file/include source and extends tag source
Plug 'fszymanski/deoplete-emoji' " EMOJI
" Plug 'ujihisa/neco-look'       " SPELL deoplete spelling source ... word completion with 'look' command ref man look
" deoplete sources filetpes
Plug 'Shougo/neco-vim'          " VIM autocompletions https://github.com/Shougo/neco-syntax
Plug 'zchee/deoplete-jedi'      " PYTHON autocompletions https://github.com/Shougo/neco-syntax
Plug 'mhartington/nvim-typescript', { 'do': function('DoRemote')} " TYPESCRIPT https://github.com/mhartington/nvim-typescript
Plug 'fszymanski/deoplete-emoji' "EMOJI
Plug 'Konfekt/FastFold'           "recomended Shougo plugin
" Plug 'wellle/tmux-complete.vim' " https://github.com/wellle/tmux-complete.vim
" Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" Plug 'benekastah/neomake'     " linting
" Plug 'janko-m/vim-test'       " do everthing with accio
" Plug 'Chiel92/vim-autoformat' " formating TODO: https://github.com/Chiel92/vim-autoformat
" Plug 'simnalamburt/vim-mundo'   " history
" Plug 'christoomey/vim-tmux-runner'
Plug 'rbgrouleff/bclose.vim' "delete buffer without closing window
Plug 'szw/vim-maximizer' " zoom vim window
" Editing Code manipulation
Plug 'junegunn/vim-peekaboo' " https://github.com/junegunn/vim-peekaboo
Plug 'unblevable/quick-scope'  " https://github.com/unblevable/quick-scope
Plug 'junegunn/vim-easy-align' " https://github.com/junegunn/vim-easy-align
" yanking
Plug 'machakann/vim-highlightedyank' " highligh yank text
Plug 'bfredl/nvim-miniyank'          " https://github.com/bfredl/nvim-miniyank
" Plug 'cohama/lexima.vim'
" Plug 'Raimondi/delimitMate' " https://github.com/Raimondi/delimitMate
Plug 'tpope/vim-commentary'  , { 'on': ['<Plug>Commentary', '<Plug>CommentaryLine', '<Plug>ChangeCommentary'] }
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
" sessions:
Plug 'mhinz/vim-startify'
"
" Plug 'tpope/vim-obsession'        "
" Plug 'dhruvasagar/vim-prosession' " each git project has associated vim session
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
Plug 'othree/nginx-contrib-vim', {'for': 'nginx'} " NGINX
Plug 'ledger/vim-ledger'                          " lEDGER
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
" XQUERY
"Plug 'vim-scripts/XQuery-indentomnicompleteftplugin' " might have to install manually
call plug#end()

"}}}
"Themes and Colorscheme {{{
Plug 'junegunn/seoul256.vim'
Plug 'trevordmiller/nova-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline#extensions#ale#enabled = 1
call plug#end()
" syntax enable
set background=dark
" let g:seoul256_background = 236
" colorscheme seoul256
set termguicolors
colorscheme nova
" execute ':highlight Pmenu ctermbg=DarkGrey'
" highlight Pmenu ctermbg=DarkGrey
" highlight TermCursor ctermfg=red guifg=red
" }}}
" BASIC SETTINGS {{{
" ==================

augroup vimrc
  autocmd!
augroup END

" Editor UI Appearance {{{
" MOUSE
set mouse=a
set mousemodel=popup_setpos
" window  settings {{{
set notitle             " No need for a title
set noequalalways       " Don't resize windows on split or close
set winwidth=30         " Minimum width for current window
set winheight=1         " Minimum height for current window
set splitbelow
set splitright
"}}}

" set noruler             " Disable default status ruler
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
set shortmess+=c
" set shortmess=aoOTI     " Shorten messages and don't show intro
" set shortmess+=c        " https://github.com/roxma/nvim-completion-manager
" set noshowcmd           " Don't show command in status line

" Top  tabline
" ----------------
set showtabline=2       " Always show the tabs line
" set tabpagemax=30     " Already set to 50 in neovim  Maximum number of tab pages
" }}}
" nvim default set laststatus=2   Always show a status line
" main buffer window pane
set colorcolumn=120     " Highlight the 120 th character limit
set synmaxcol=200
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
" Complete Options
" -----------------
" :h complete
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" bu


" Popup Menu Styling
" ------------------
set previewheight=8     " Completion preview height
set pumheight=20        " Pop-up menu's line height
"complete options
" :h complete
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" bu
set completeopt+=menuone
set completeopt+=noinsert       " auto select feature like neocomplete
set completeopt+=noselect
" set completeopt=-preview
" set completeopt+=longest

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
let g:loaded_netrwPlugin = 1
set hidden
set noswapfile
set nobackup
set undofile
set undolevels=5000
set undoreload=10000
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
set sessionoptions-=globals
set sessionoptions-=help
" Project and File Management Plugins
" - eunuch
" - projectionist
" - startify
" - fzf
" }}}
" }}}
" PLUGIN SETTINGS {{{
" - dirvish
" - fzf
"===========
" DIRVISH {{{
"============ {{{
"@see https://github.com/justinmk/vim-dirvish
"@help dirvish-options
" NOTES:
"  Shdo mv {} {}copy.txt
"  Shodo! mv % %copy.txt
let g:dirvish_mode = 1
let g:dirvish_relative_paths = 0
let g:dirvish_mode = ':sort r /\/$/'

augroup my_dirvish_events
  autocmd!
  " Same as FZF
  autocmd FileType dirvish
        \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
        \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
  " Enable :Gstatus and friends.
  " autocmd FileType dirvish call fugitive#detect(@%)
  "|

  " Map `gr` to reload the Dirvish buffer.
  "

  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

  " autocmd FileType dirvish nnoremap <silent> <Tab> <Esc>:call g:SmartTab()<CR>

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer>
        \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END
" }}}
" Fuzzy Find Files and things in files with FZF {{{
" https://github.com/junegunn/fzf/wiki/
" https://github.com/junegunn/fzf.vim
" Default fzf layout
" - down / up / left / right
" - window (nvim only)
"let $FZF_DEFAULT_OPTS .= ' --inline-info'
let g:fzf_layout = { 'down': '~40%' }

" ctrl-[a-z], alt-[a-z], f[1-4], or any single character
let g:fzf_action = {
      \ 'ctrl-p': 'edit',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-o': 'botright split',
      \ 'ctrl-a':  'vertical botright split' }
"nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>f  :GitFiles<CR>
nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>t  :Tags<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
"
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
if executable('rg')

  set grepprg=rg\ --vimgrep
  "                 |
  "                 `------------ Format results for Vim, include multiple matches per line
  set grepformat=%f:%l:%c:%m
else
  set grepprg=grep\ -rnH\ --exclude='.*.swp'\ --exclude='*~'\ --exclude=tags
  "                  |||
  "                  ||`--------- Always print file names
  "                  |`---------- Print line numbers
  "                  `----------- Search directories recursively
endif
" }}}
" }}}
" PLUGGED
" nvim-miniyank
" https://github.com/bfredl/nvim-miniyank
" map p <Plug>(miniyank-autoput)
" map P <Plug>(miniyank-autoPut)

" map <Leader>p <Plug>(miniyank-startput)
" map <Leader>P <Plug>(miniyank-startPut)

" map <leader>n <Plug>(miniyank-cycle)
" map <Leader>c <Plug>(miniyank-tochar)
" map <Leader>l <Plug>(miniyank-toline)
" map <Leader>b <Plug>(miniyank-toblock)

" Auto Completions and Snippets and Templates {{{
" -----------------------------------------------
" let g:asyncomplete_log_file = expand('~/asyncomplete.log')
" let g:lsp_log_file = expand('~/vim-lsp.log')
" let g:lsp_log_verbose = 1
" let g:lsp_async_completion = 1
" autocmd FileType typescript setlocal omnifunc=lsp#complete

"  Autocompletionn
" deoplete with
"  - echodoc
"  - vim-projectionist
"  - ultisnips
"@ see https://noahfrederick.com/log/vim-templates-with-ultisnips-and-projectionist
"@ https://www.youtube.com/watch?v=QsLTYEVJ6JU
"http://www.dirv.me/generating-src-spec-vim/index.html

"===========
" SUPERTAB     https://github.com/ervandew/supertab.git
"============
let g:SuperTabDefaultCompletionType = '<c-n>'
" make the tabing on completion menu go from top to bottom
let g:SuperTabClosePreviewOnPopupClose = 1    " Close the preview when completion ends
" let g:SuperTabLongestEnhanced  = 1 " Enhanced longest match support: default 0
" let g:SuperTabLongestHighlight = 1 " default 0

"=============
"   ECHODOC
"==============
let g:echodoc_enable_at_startup = 1
" set cmdheight=2 @see above
" cmdheight

"==============
"   DEOPLETE
"===============
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 150  " Default is 50
" let g:deoplete#auto_refresh_delay = 500  " Default is 500
" let g:deoplete#enable_refresh_always = 1
" if working on plugin uncomment next 3 lines
let g:deoplete#enable_debug = 1
let g:deoplete#enable_profile = 1
call deoplete#enable_logging('DEBUG', expand( $CACHEPATH . '/deoplete.log'))
" if !exists('g:deoplete#omni#input_patterns')
"   let g:deoplete#omni#input_patterns = {}
" endif
" let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_camel_case = 1
" " let g:deoplete#disable_auto_complete = 1
let g:deoplete#auto_completion_start_length = 3
let g:deoplete#max_abbr_width = 35
let g:deoplete#max_menu_width = 20
let g:deoplete#tag#cache_limit_size = 800000
let g:deoplete#file#enable_buffer_path = 1

" sources:
" Note: come with default sources
" buffer      It collects keywords from current buffer and the buffers which have same 'filetype'.
" member:     It collects members from current buffer.
" tag:        It collects keywords from ctags files
" file:       This source collects keywords from local files.
" omni:       This source collects keywords from 'omnifunc'. Note: It is not asynchronous.
" dictionary: This source collects keywords from 'dictionary'.
" around:     This source collects candidates around the cursor external sources
"
" Help deoplete-external-sources
" ---------------------------------------------------------------------------------------------------
" UltiSnips ... https://github.com/SirVer/ultisnips
" https://github.com/SirVer/ultisnips/blob/master/rplugin/python3/deoplete/sources/ultisnips.py
" ---------------------------------------------------------------------------------------------------
" syntax ... deoplete source analyzes a syntax file like autoload/syntaxcomplete.vim with more candidates
"            defaults to 4 keyword letter length
" https://github.com/Shougo/neco-syntax/blob/master/rplugin/python3/deoplete/sources/syntax.py
" ---------------------------------------------------------------------------------------------------
" look         ... neco-look  ref man look
" ---------------------------------------------------------------------------------------------------
" file/include ... neoinclude
" ---------------------------------------------------------------------------------------------------
" file types
" vim  necovim  https://github.com/Shougo/neco-syntax/blob/master/rplugin/python3/deoplete/sources/syntax.py

" Language Servers
" typescript javascript  ... mhartington/nvim-typescript
"
" ternjs ... deoplete-ternjs: ternjs source for JavaScript https://github.com/carlitux/deoplete-ternjs
" https://github.com/carlitux/deoplete-ternjs/blob/master/rplugin/python3/deoplete/sources/ternjs.py
" ---------------------------------------------------------------------------------------------------

" omnifuncs
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" augroup end

" limit sources
let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file']

let g:deoplete#sources = {}
" ALL underscore means all sources
" let g:deoplete#sources._ = [ 'buffer', 'member', 'tag', 'file', 'dictionary', 'syntax', 'around', 'file/include' ]
" FILETYPES value is used for default filetypes
" key is filetype and value is the filetypes source names
" the source name is found in the py file
" rplugin/python3/deoplete/sources/deoplete_jedi.py
" let g:deoplete#sources.xquery = ['ultisnips', 'tag', 'syntax']  " set values for each filetype
" let g:deoplete#sources.xquery = ['omni']  " set values for each filetype
" let g:deoplete#sources.html = ['omni','ultisnips', 'buffer', 'tag']  " set values for each filetype
" let g:deoplete#sources.javascript = [ 'ternjs', 'ultisnips', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.vim = ['vim', 'around', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.python = ['jedi']
let g:deoplete#sources.xquery = ['xQuery']  " set values for each filetype
" let g:deoplete#sources.typescript = ['LanguageClient']
" let g:deoplete#sources#jedi#statement_length = 30
" let g:deoplete#sources#jedi#show_docstring = 1
" let g:deoplete#sources#jedi#short_types = 1
" Omni functions
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'
let g:deoplete#omni#functions.html = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.markdown = 'htmlcomplete#CompleteTags'
" Omni patterns
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.html = '<[^>]*'
" Omni input patterns
let g:deoplete#omni#input_patterns = {}
let g:deoplete#omni#input_patterns.xml = '<[^>]*'
let g:deoplete#omni#input_patterns.md = '<[^>]*'
let g:deoplete#omni#input_patterns.css = '^\s\+\w\+\|\w\+[):;]\?\s\+\w*\|[@!]'
" CUSTOM SOURCES
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#source('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#source('_', 'disabled_syntaxes', ['Comment', 'String'])
call deoplete#custom#source('_', 'min_pattern_length', 2)
" MARKS
call deoplete#custom#source('around',   'mark', '↻')
call deoplete#custom#source('buffer',   'mark', 'ℬ')
call deoplete#custom#source('jedi',     'mark', '⌁')
call deoplete#custom#source('omni',     'mark', '⌾')
call deoplete#custom#source('syntax',   'mark', '♯')
call deoplete#custom#source('tag',      'mark', '⌦')
call deoplete#custom#source('vim',      'mark', '⌁')
call deoplete#custom#source('ultisnips','mark', 'μ')
" RANK  default rank is 100, higher is better.
call deoplete#custom#source('around',      'rank', 330)
call deoplete#custom#source('buffer',      'rank', 320)
call deoplete#custom#source('dictionary',  'rank', 310)
call deoplete#custom#source('file',        'rank', 410)
call deoplete#custom#source('file_include','rank', 420)
call deoplete#custom#source('jedi',        'rank', 610)
call deoplete#custom#source('member',      'rank', 500)
call deoplete#custom#source('omni',        'rank', 550)
call deoplete#custom#source('syntax',      'rank', 200)
call deoplete#custom#source('tag',         'rank', 400)
call deoplete#custom#source('vim',         'rank', 630)
call deoplete#custom#source('ultisnips',   'rank', 600)

" https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim
" Matchers and Converters

" typescript
" g:nvim_typescript#server_path = '../node_modules/.bin/tsserver'
let g:nvim_typescript#javascript_support = 1
" let g:nvim_typescript#max_completion_detail = 25 " default
let g:nvim_typescript#type_info_on_hold = 1
" g:nvim_typescript#signature_complete = 0 " default this is disabled in favor of echodoc
" g:nvim_typescript#loc_list_item_truncate_after = 20 " default
" see more settings
"======================
" LanguageClient-neovim
"======================

" let g:LanguageClient_serverCommands = {
"     \ 'typescript': ['tsserver', '--stdio'],
"     \ }


" Automatically start language servers.
" let g:LanguageClient_autoStart = 1
" let g:LanguageClient_trace = 'verbose'

"===============
"   UltiSnips
"===============
" functions and mappings to make ultisnips and deoplete work together
"@see https://github.com/simonweil/dotfiles/blob/master/nvimrc
"@see https://github.com/SirVer/ultisnips/blob/master/autoload/UltiSnips/map_keys.vim#L56
" https://github.com/simonweil/dotfiles/blob/master/nvimrc#L29-L85
let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<NOP>'
let g:UltiSnipsJumpBackwardTrigger = '<NOP>'
let g:SuperTabMappingForward = '<NOP>'
let g:SuperTabMappingBackward = '<NOP>'
let g:UltiSnipsMappingsToIgnore = [ 'SmartTab', 'SmartShiftTab' ] " Don't unmap my mappings
let g:ulti_expand_res = 0    " Make <CR> smart

function! Ulti_ExpandOrEnter()
  " First try to expand a snippet
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res
    " if successful, just return
    return ''
  elseif pumvisible()
    " if in completion menu - just close it and leave the cursor at the
    " end of the completion
    return deoplete#mappings#close_popup()
  else
    " otherwise, just do an "enter"
    return "\<return>"
  endif
endfunction

" Enable tabbing and shift-tabbing through list of results
function! g:SmartTab()
  if pumvisible()
    return SuperTab('n')
  else
    call UltiSnips#JumpForwards()
    if g:ulti_jump_forwards_res == 0
      return SuperTab('n')
    endif
    return ''
  endif
endfunction

function! g:SmartShiftTab()
  if pumvisible()
    return SuperTab('p')
  else
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
      return SuperTab('p')
    endif
    return ''
  endif
endfunction

" COMPLETION MAPPINGS
" -------------------
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>
inoremap <silent> <Tab> <C-R>=g:SmartTab()<CR>
snoremap <silent> <Tab> <Esc>:call g:SmartTab()<CR>
inoremap <silent> <s-Tab> <C-R>=g:SmartShiftTab()<CR>
snoremap <silent> <s-Tab> <Esc>:call g:SmartShiftTab()<CR>
" Creating and Editing Snips
" --------------------------
let g:UltiSnipsSnippetsDir = expand('$DATAPATH/snips')
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
let g:UltiSnipsEditSplit = 'vertical'

" let g:SuperTabCrMapping = 1 " (default value: 0)
" }}}
" Windows and Buffers
" <F12> open|close terminal
" <F11> Maximize window with vim-maximizer
" <F10> open|closetags window with tagbar

" {{{ terminal buffer
"  nvimux is just a series of keybindings to allow neovim to work similarly to TMUX.
"  let g:nvimux_prefix='<C-b>'
"  let g:nvimux_quickterm_scope = 'g'
"  let g:nvimux_quickterm_direction = 'botright'
"  let g:nvimux_quickterm_orientation = 'vertical'
"  let g:nvimux_quickterm_size = ''
"  nvimux_override_n=":term<CR>"
" let g:nvimux_custom_bindings = [
"     \['\|', ':NvimuxVerticalSplit<CR>', ['n', 'v', 'i', 't']],
"     \['-', ':NvimuxHorizontalSplit<CR>', ['n', 'v', 'i', 't']],
"     \]

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" when in terminal go back to previous window
" https://neovim.io/doc/user/nvim_terminal_emulator.html#nvim-terminal-emulator
" tnoremap <F12> <C-\><C-n><C-w><C-p>
" set ttimeoutlen=1
" term colors
" hi! link TermCursor Cursor
" hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE
"
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> ii<C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" tnoremap <expr> <A-r> '<C-\><C-n>'.nr2char(getchar()).'pi'
" https://neovim.io/doc/user/options.html#%27term%27
" https://neovim.io/doc/user/autocmd.html#TermClose
" TermChanged, TermClose, TermResponse

set switchbuf+=useopen

" function! TermEnter()
"   let l:bufcount = bufnr('$')
"   let l:currbufnr = 1
"   let l:nummatches = 0:
"   let l:firstmatchingbufnr = 0
"   while l:currbufnr <= l:bufcount
"     if(bufexists(l:currbufnr))
"       let l:currbufname = bufname(l:currbufnr)
"       if(match(l:currbufname, 'term://') > -1)
"         echo l:currbufnr . ': '. bufname(l:currbufnr)
"         let l:nummatches += 1
"         let l:firstmatchingbufnr = l:currbufnr
"         break
"       endif
"     endif
"     let l:currbufnr = l:currbufnr + 1
"   endwhile
"   if(l:nummatches >= 1)
"     execute ':sbuffer '. l:firstmatchingbufnr
"     startinsert
"   else
"     execute ':Topen'
"   endif
" endfunction
" map esc in term
tnoremap <Esc> <C-\><C-n>

" nnoremap <silent> <F6> :call TermEnter()<CR>
" when in terminal go back to previous window
" tnoremap <silent>  <F6> <C-\><C-n><C-w><C-p>

"========
" NEOTERM
"========
"help neoterm
"@see https://github.com/kassio/neoterm
" :Tnew  " open new termnal
" :T pwd " send cmd to term
" :Tclear "
" :Tclose " close window , buffer still exists so,
" can still send commands to it with :T
"  :T %  " can sen special commands
"help cmdline-special

let g:neoterm_size = 5
let g:neoterm_fixedsize = 1
let g:neoterm_position = 'horizontal'
let g:neoterm_keep_term_open = 1
let g:neoterm_autoscroll = 1

" let g:neoterm_autoinsert = 1
nnoremap <silent> <F8> :TREPLSendLine<CR>
vnoremap <silent> <F8> :TREPLSendSelection<CR>
noremap  <silent> <F7> :TREPLSendFile<CR>

" nnoremap  <silent> <F6> :Topen<CR>
"
" set <S-F3>=^[O1;2R
"  nnoremap <S-F3> :Tclose<CR>
" nnoremap <silent> <F12> :Ttoggle<CR>
" tnoremap <silent> <F12> <C-\><C-n><C-w><C-p>

command! -nargs=+ Tmake :T make <args>
command! -nargs=+ Tlog :T tail -f <args>
" pip3 install --user neovim-remote

" }}}
" maximizer {{{
let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<F11>'
" }}}
" Tags created by universal-ctags and views created with tagbar {{{
" Notes: ctags config
" map <F10> :TagbarToggle<CR>
" Note: <leader>'t'  Fuzzy Find
"let g:gutentags_cache_dir = '$CACHEPATH/tags'
" let g:tagbar_type_css = {
"       \ 'ctagstype' : 'Css',
"       \ 'kinds'     : [
"       \ 'c:classes',
"       \ 's:selectors',
"       \ 'i:identities'
"       \ ]
"       \ }

" let g:tagbar_type_make = {
"       \ 'kinds':[
"       \ 'm:macros',
"       \ 't:targets'
"       \ ]
"       \}

" let g:tagbar_type_markdown = {
"       \ 'ctagstype' : 'markdown',
"       \ 'kinds' : [
"       \ 'h:Heading_L1',
"       \ 'i:Heading_L2',
"       \ 'k:Heading_L3'
"       \ ]
"       \ }

" let g:tagbar_type_xquery = {
"       \ 'ctagstype' : 'xquery',
"       \ 'kinds'     : [
"       \ 'f:function',
"       \ 'v:variable',
"       \ 'm:module',
"       \ ]
"       \ }

" let g:tagbar_type_xsd = {
"       \ 'ctagstype' : 'XSD',
"       \ 'kinds'     : [
"       \ 'e:elements',
"       \ 'c:complexTypes',
"       \ 's:simpleTypes'
"       \ ]
"       \ }

" let g:tagbar_type_xslt = {
"       \ 'ctagstype' : 'xslt',
"       \ 'kinds' : [
"       \ 'v:variables',
"       \ 't:templates'
"       \ ]
"       \}
" }}}
" Dirvish {{{
let g:loaded_netrwPlugin = 12
" nnoremap <silent> <F9> :ProjectRootExe Dirvish<cr>
"autocmd User ProjectionistActivate silent! call snippet#InsertSkeleton()

"}}}
" Sessions with startify  {{{
" What not to save in sessions:
" set sessionoptions-=options  neovim default
let g:startify_session_dir =  expand($CACHEPATH . '/session')
let g:startify_session_autoload = 1
let g:startify_session_persistence = 1
let g:startify_session_delete_buffers = 1
" let g:startify_session_before_save = [
"     \ 'echo "Cleaning up before saving.."',
"     \ 'silent! NERDTreeTabsClose'
" \ ]
" let g:startify_session_remove_lines = []
" let g:startify_session_savevars = []
" let g:startify_session_savecmds = []
let g:startify_files_number = 1
let g:startify_relative_path = 1
let g:startify_change_to_vcs_root = 1
let g:startify_fortune_use_unicode = 1
let g:startify_session_number = 5
let g:startify_session_sort = 1

let g:startify_list_order = [
      \ ['  SESSIONS:'],
      \ 'sessions',
      \ ['   MRU files: '],
      \ 'files',
      \ ['   MRU in current directory:'],
      \ 'dir',
      \ ['   BOOKMARKS:'],
      \ 'bookmarks',
      \ ['   COMMANDS:'],
      \ 'commands',
      \ ]

hi StartifyBracket ctermfg=240
hi StartifyFile    ctermfg=147
hi StartifyFooter  ctermfg=240
hi StartifyHeader  ctermfg=114
hi StartifyNumber  ctermfg=215
hi StartifyPath    ctermfg=245
hi StartifySlash   ctermfg=240
hi StartifySpecial ctermfg=240
" let g:startify_session_sort = 0
" let g:startify_session_number = 999
" save everything here
" ls  $HOME/.cache/nvim/session/
" rm  $HOME/.cache/nvim/session/*
set sessionoptions-=globals
set sessionoptions-=help

" http://vim.wikia.com/wiki/Quick_tips_for_using_tab_pages
" set sessionoptions=blank,buffers,curdirs,tabpages,winsize

" let g:prosession_tmux_title = 1
" let g:prosession_tmux_title_format = 'neovim @@@'
" let g:prosession_on_startup = 1
" let g:prosession_default_session = 0
" let g:prosession_per_branch = 0
" let g:prosession_branch_cmd = 'git rev-parse --abbrev-ref HEAD 2>/dev/null' " for each branch
" let g:prosession_dir = expand($CACHEPATH . '/session')
" }}}
" Linting with ALE" {{{
" :h ale
" map ]a <Plug>(ale_next_wrap)
" nmap [a <Plug>(ale_previous_wrap)
" let g:ale_lint_delay = 1000
" let g:ale_lua_luacheck_options = '--std ngx_lua'
" let g:ale_linters = { 'xquery': [ 'xQcompile'] }
" ---------------------------------------------------------------------
" Accio
" ----------------------------------------------------------------------
" let g:accio_create_empty_quickfix = 1
" let g:accio_auto_copen = 0 "automatically open quick list
" let g:accio_update_interval = 250





" Note:  Noah Frederick's  after ... sets text and signs
" @see gf 'after/plugin/accio.vim'
" @see 'Noah Frederick'

" NOTE:
" one filetype can have many compilers
" HTML
" @see 'nvim/ftplugin/html.vim'
" @see 'nvim/compiler/tidy.vim'
" XQUERY
" @gf nvim/site/ftplugin/xquery.vim
" @gf nvim/site/compiler/xqm.vim




" }}}
"
let g:gista#client#use_git_config_github_user = 1
"}}}
" Functions {{{
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>l:buflist
  silent! ls!
  redir END
  return l:buflist
endfunction

function! ToggleList(bufname, pfx)
  let l:buflist = GetBufferList()
  for l:bufnum in map(filter(split(l:buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(l:bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx ==# 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo 'Location List is Empty.'
    return
  endif
  let l:winnr = winnr()
  exec(a:pfx.'open 3')
  if winnr() != l:winnr
    wincmd p
  endif
endfunction

function! StylePreviewWindow()
  if &previewwindow
    setlocal nowrap
    setlocal norelativenumber
    setlocal nonumber
  endif
endfunction

" function! AutoProjectRootCD()
"   try
"      execute ':tcd ' . system('git rev-parse --show-toplevel')
"   catch
"     " Silently ignore invalid buffers
"   endtry
" endfunction

" function! CdTop()
"   try
"      execute ':lcd ' . system('git rev-parse --show-toplevel')
"   catch
"     " Silently ignore invalid buffers
"   endtry
" endfunction

function! AccioDo()
  if !empty(b:projectionist)
    " let l:pRoot =  projectionist#path()
    " echo 'project: ' . l:pRoot
    " echomsg 'Working On: ' . expand('%')
    for [ l:root, l:value] in projectionist#query('prove')
      " execute ':Tclose'
      " execute ':T1 clear'
      " execute  expand(':T1 echo "Project Root: ' . l:root . '"')
      " execute  expand(':T1 echo "Prove File: ' . l:value . '"')
      execute  ':write %'
      execute  ':Accio ["xQprove"]'
      break
    endfor
  endif
endfunction

" function! <SID>ProjectActivate()
"   try
"     if &filetype !=# '' && &filetype !~# 'dirvish|git'
"       for [s:root, s:value] in projectionist#query("framework")
"         if index(split(&filetype, '\.'), s:value) < 0
"           let &filetype = join([&filetype, s:value], ".")
"         endif
"       endfor
"       call snippet#InsertSkeleton()
"     endif

"   catch
"     " Silently ignore invalid buffers
"   endtry
" endfunction
" }}}
" Mappings and Abbreviations {{{
"


" LEADER MAPPINGS - my leader is the space bar
nnoremap <silent> <leader>d :Dirvish %:p:h<CR>
nnoremap <silent> <leader>tb :tabnew<space>

"typing :make is much too long anyway
nnoremap <leader>m :make<CR>
" Toggle quicklist locallist
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>

nnoremap <silent> <leader>w :StripWhitespace<CR>

nnoremap <silent> <F2>  :UltiSnipsEdit<CR>
nnoremap  <F5> :call AccioDo()<CR>

" nmap <Leader><Space>o :copen<CR>      " open location window
" nmap <Leader><Space>c :cclose<CR>     " close location window
" nmap <Leader><Space>, :ll<CR>         " go to current error/warning
" nmap <Leader><Spzace>n :cnext<CR>      " next error/warning
" nmap <Leader><Space>p :cprev<CR>      " previous error/warning
" autocmd! InsertChange,TextChanged *.html update | :Accio [ "tidy", "xmlwf", "xmllint" ]

" <F8> sav and run checker
"  autocmd BufWrite <buffer> Accio ["xqm"]

" commentary maps, since it is loaded lazily
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>CommentaryLine

"}}}
" {{{ Initialise
augroup init
  autocmd!
  autocmd BufWritePost $MYVIMRC nested source $MYVIMR
  " autocmd BufEnter * :syntax sync fromstart
  " NOTE: filetype
  " detection -- '/usr/share/nvim/runtime/filetype.vim'
  " make recognizes  mk extension
  " xquery recognizes xql xqm xq
  " autocmd TabNewEntered * call OnTabEnter(expand("<amatch>"))

  autocmd BufNewFile,BufRead *.conf set filetype=nginx "add nginx filetype for any conf extension
  " autocmd BufNewFile,BufRead .env.* setfiletype sh
  autocmd BufNewFile,BufRead *.t set filetype=tap  "  using test more bash instead of perl
  autocmd BufNewFile,BufRead *.snippets set filetype=snippets "add new snippets filetpe
  " autocmd TabNewEntered * call AutoProjectRootCD()
  autocmd BufWinEnter * call StylePreviewWindow()
  " when entering a buffer look for project root and change dir"
  " our shell commands 'make' etc run from project root
  "@see https://subvisual.co/blog/posts/135-super-powered-vim-part-iii-skeletons/
  " autocmd User ProjectionistActivate silent! call <SID>ProjectActivate()
  " autocmd BufNewFile * silent! call snippet#insert_skeleton()


  " " SYNTAX
  " autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
  "       \ 'name': 'necosyntax',
  "       \ 'whitelist': ['*'],
  "       \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
  "       \ }))

  " " BUFFER
  " autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  "       \ 'name': 'buffer',
  "       \ 'whitelist': ['*'],
  "       \ 'blacklist': ['go'],
  "       \ 'completor': function('asyncomplete#sources#buffer#completor'),
  "       \ }))

  " let g:UltiSnipsExpandTrigger="<c-e>"
  " "  SNIPS ultisnips autocomplete
  " autocmd User asyncomplete_setup call  asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
  "       \ 'name': 'ultisnips',
  "       \ 'whitelist': ['*'],
  "       \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
  "       \ }))

  " " VIM autocomplete
  " autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
  "       \ 'name': 'necovim',
  "       \ 'whitelist': ['vim'],
  "       \ 'completor': function('asyncomplete#sources#necovim#completor'),
  "       \ }))

  " if executable('pyls')
  "   " pip install python-language-server
  "   autocmd User lsp_setup call lsp#register_server({
  "         \ 'name': 'pyls',
  "         \ 'cmd': {server_info->['pyls']},
  "         \ 'whitelist': ['python'],
  "         \ })
  " endif

  " augroup END
  " " if executable('typescript-language-server')
  " "     au User lsp_setup call lsp#register_server({
  " "         \ 'name': 'typescript-language-server',
  " "         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server', '--stdio']},
  " "         \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
  " "         \ 'whitelist': ['typescript'],
  " "         \ })
  " " endif

  " }}}
