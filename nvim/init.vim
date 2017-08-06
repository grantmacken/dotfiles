scriptencoding utf-8
" XDG Paths {{{

if exists("$XDG_CONFIG_HOME")
  let $VIMPATH=expand('$XDG_CONFIG_HOME/nvim')
  let $VARPATH=expand('$XDG_CACHE_HOME/nvim')
  let $DATAPATH=expand('$XDG_DATA_HOME/nvim')
else
  let $VIMPATH=expand('$HOME/.config/nvim')
  let $VARPATH=expand('$HOME/.cache/nvim')
  let $DATAPATH=expand('$HOME/.local/share/nvim')
endif

" }}}
" Global Mappings "{{{
" https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
" pyenv activate neovim3
" pip install neovim
" https://github.com/mhinz/neovim-remote
" let g:neoterm_automap_keys = ',tt'
let g:python_host_prog = '/home/gmack/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/gmack/.pyenv/versions/neovim3/bin/python'
"
" Use spacebar instead of '\' as leader. Require before loading plugins.
let g:mapleader="\<Space>"
let g:maplocalleader=','
" Release keymappings for plug-in.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
" }}}
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
set completeopt+=menuone
set completeopt+=noinsert       " auto select feature like neocomplete
set completeopt+=noselect
" set completeopt+=preview
" set completeopt+=longest

" Popup Menu Styling
" ------------------
"set previewheight=8     " Completion preview height
set pumheight=20        " Pop-up menu's line height
"complete options
" :h complete
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" bu
set completeopt+=menuone
set completeopt+=noinsert       " auto select feature like neocomplete
set completeopt+=noselect
" set completeopt+=preview
" set completeopt+=longest

" Spelling
" --------
let g:spell_add=expand($VARPATH . '/spell/en.utf-8.add')
exec "set spellfile=" . g:spell_add

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
" Add In Plugins {{{
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin(expand('$VIMPATH/plugged'))
" File_And_Project_Management {{{
" ---------------------------
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-projectionist'
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
Plug 'jreybert/vimagit'
" Plugt'lambdalisue/vim-gita'
"projectionist#query("framework")
"
" Code Lint Compile Build Test
" ----------------------------
Plug 'w0rp/ale'
" let g:airline#extensions#ale#enabled = 1
" navigate between errors
" nmap <silent> <C-k> <Plug>(ale_previous_wrap)
" nmap <silent> <C-j> <Plug>(ale_next_wrap)
" use quicklist instead of locallist
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
"

Plug 'pgdouyon/vim-accio' "@see https://github.com/pgdouyon/vim-accio
" Used for Async
" - Check             [ 'format', 'lint' ] ( on buffer text change  )
" - Compile Builds    [ 'compile' ]        ( on save compile  )
" - Test              [ 'prove' ]          ( on build run asseertion and functional tests )


" Feedback
" - Populating the quickfix list
" - Placing signs on the line of the found error
" - Echoing the error message when the cursor is on an error line.
" @see compiler

Plug 'kassio/neoterm'
" Plug 'janko-m/vim-test'
"
" Plug 'sbdchd/neoformat'
"
" Auto Completions and Snippets.
" ------------------------------
" Plug 'roxma/nvim-completion-manager' " can't handle multiple invim instances
" Plug 'roxma/python-support.nvim'
" let g:python_support_python2_require = 0
" Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'     " https://github.com/SirVer/ultisnips
Plug 'honza/vim-snippets'
" deoplete sources
Plug 'Shougo/context_filetype.vim'
Plug 'https://github.com/Shougo/neco-syntax' " https://github.com/Shougo/neco-syntax
Plug 'Shougo/neoinclude.vim' "deoplete file/include source and extends tag source
Plug 'fszymanski/deoplete-emoji'
Plug 'ujihisa/neco-look' "deoplete spelling source ... word completion with 'look' command ref man look
Plug 'Konfekt/FastFold'      "recomended Shougo plugin
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
" Plug 'Shougo/echodoc'  " recomended plugin .. to look at function auguments
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
Plug 'othree/yajs.vim', { 'for': 'javascript' }          " JAVASCRPT SYNTAX object/method data comes from Mozilla's WebIDL
Plug 'HerringtonDarkholme/yats.vim',{'for':'javascript'} " TYPESCRIPT
Plug 'gavocanov/vim-js-indent'                           " JAVASCRIPT INDENT
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
" Themes and Colorscheme {{{
Plug 'junegunn/seoul256.vim'
Plug 'trevordmiller/nova-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#ale#enabled = 1
call plug#end()
" syntax enable
set background=dark
" set t_Co=256                   " 256 colors for the terminal
" let g:seoul256_background = 236
" colorscheme seoul256
set termguicolors
colorscheme nova
" execute ':highlight Pmenu ctermbg=DarkGrey'
" highlight Pmenu ctermbg=DarkGrey
" highlight TermCursor ctermfg=red guifg=red
" }}}

" PLUGINS
" - dirvish
" - fzf
"===========
" DIRVISH
" "============
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
  autocmd FileType dirvish nnoremap <silent><buffer> gr :<C-U>Dirvish %<CR>

  " autocmd FileType dirvish nnoremap <silent> <Tab> <Esc>:call g:SmartTab()<CR>

  " Map `gh` to hide dot-prefixed files.
  " To "toggle" this, just press `R` to reload.
  autocmd FileType dirvish nnoremap <silent><buffer>
    \ gh :silent keeppatterns g@\v/\.[^\/]+/?$@d<cr>
augroup END
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

let g:SuperTabDefaultCompletionType = "<c-n>" " make the tabing on completion menu go from top to bottom
let g:SuperTabClosePreviewOnPopupClose = 1    " Close the preview when completion ends
" let g:SuperTabLongestEnhanced  = 1 " Enhanced longest match support: default 0
" let g:SuperTabLongestHighlight = 1 " default 0
" neovim

"=============
"   ECHODOC
"==============
" let g:echodoc_enable_at_startup = 1
" set cmdheight=2 @see above
" cmdheight

"==============
"   DEOPLETE
"===============
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#enable_smart_case = 1
" let g:deoplete#disable_auto_complete = 1
let g:deoplete#auto_completion_start_length = 3
let g:deoplete#max_menu_width = 120
let g:deoplete#max_abbr_width = 80
let g:deoplete#max_menu_width = 120
let g:deoplete#autocomplete_delay = 50

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
" ternjs ... deoplete-ternjs: ternjs source for JavaScript https://github.com/carlitux/deoplete-ternjs
" https://github.com/carlitux/deoplete-ternjs/blob/master/rplugin/python3/deoplete/sources/ternjs.py
" ---------------------------------------------------------------------------------------------------
" syntax ... deoplete source analyzes a syntax file like autoload/syntaxcomplete.vim with more candidates
"            defaults to 4 keyword letter length
" https://github.com/Shougo/neco-syntax/blob/master/rplugin/python3/deoplete/sources/syntax.py
" ---------------------------------------------------------------------------------------------------
" look         ... neco-look  ref man look
" ---------------------------------------------------------------------------------------------------
" file/include ... neoinclude
" ---------------------------------------------------------------------------------------------------
" omnifuncs
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"   autocmd FileType xquery setlocal omnifunc=xquerycomplete#Complete
" augroup end

let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file']

let g:deoplete#sources = {}
let g:deoplete#sources._ = [ 'buffer', 'member', 'tag', 'file', 'dictionary', 'syntax', 'around', 'file/include' ]


" '_'  value is used for default filetypes

let g:deoplete#sources.xquery = ['ultisnips', 'tag', 'syntax']  " set values for each filetype
" let g:deoplete#sources.xquery = ['omni']  " set values for each filetype
" let g:deoplete#sources.html = ['ultisnips', 'buffer', 'tag']  " set values for each filetype
" let g:deoplete#sources.javascript = [ 'ternjs', 'ultisnips', 'buffer', 'tag']  " set values for each filetype
" let g:deoplete#sources.vim = ['vim', 'buffer', 'tag']  " set values for each filetype

" Use partial fuzzy matches like YouCompleteMe
call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
" "call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

"===============
"   UltiSnips
"===============
" functions and mappings to make ultisnips and deoplete work together
"@see https://github.com/simonweil/dotfiles/blob/master/nvimrc
"@see https://github.com/SirVer/ultisnips/blob/master/autoload/UltiSnips/map_keys.vim#L56
let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<NOP>'
let g:UltiSnipsJumpBackwardTrigger = '<NOP>'
let g:SuperTabMappingForward = '<NOP>'
let g:SuperTabMappingBackward = '<NOP>'
let g:UltiSnipsMappingsToIgnore = [ "SmartTab", "SmartShiftTab" ] " Don't unmap my mappings
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
    return SuperTab("n")
  else
    call UltiSnips#JumpForwards()
    if g:ulti_jump_forwards_res == 0
      return SuperTab("n")
    endif
    return ''
  endif
endfunction

function! g:SmartShiftTab()
  if pumvisible()
    return SuperTab("p")
  else
    call UltiSnips#JumpBackwards()
    if g:ulti_jump_backwards_res == 0
      return SuperTab("p")
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
nnoremap <silent> <F2>  :UltiSnipsEdit<CR>
let g:UltiSnipsSnippetsDir = split(&runtimepath, ',')[0] . '/snips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
let g:UltiSnipsEditSplit = "vertical"

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

tnoremap <expr> <A-r> '<C-\><C-n>"'.nr2char(getchar()).'pi'
" https://neovim.io/doc/user/options.html#%27term%27
" https://neovim.io/doc/user/autocmd.html#TermClose
" TermChanged, TermClose, TermResponse
let g:neoterm_size = 5
set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute ":Topen"
  endif
endfunction
" map esc in term
tnoremap <Esc> <C-\><C-n>
nnoremap <silent> <F6> :call TermEnter()<CR>
" when in terminal go back to previous window
tnoremap <silent>  <F6> <C-\><C-n><C-w><C-p>

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
"let g:gutentags_cache_dir = '$VARPATH/tags'
" let g:tagbar_type_css = {
" 			\ 'ctagstype' : 'Css',
" 			\ 'kinds'     : [
" 			\ 'c:classes',
" 			\ 's:selectors',
" 			\ 'i:identities'
" 			\ ]
" 			\ }

" let g:tagbar_type_make = {
" 			\ 'kinds':[
" 			\ 'm:macros',
" 			\ 't:targets'
" 			\ ]
" 			\}

" let g:tagbar_type_markdown = {
" 			\ 'ctagstype' : 'markdown',
" 			\ 'kinds' : [
" 			\ 'h:Heading_L1',
" 			\ 'i:Heading_L2',
" 			\ 'k:Heading_L3'
" 			\ ]
" 			\ }

" let g:tagbar_type_xquery = {
" 			\ 'ctagstype' : 'xquery',
" 			\ 'kinds'     : [
" 			\ 'f:function',
" 			\ 'v:variable',
" 			\ 'm:module',
" 			\ ]
" 			\ }

" let g:tagbar_type_xsd = {
" 			\ 'ctagstype' : 'XSD',
" 			\ 'kinds'     : [
" 			\ 'e:elements',
" 			\ 'c:complexTypes',
" 			\ 's:simpleTypes'
" 			\ ]
" 			\ }

" let g:tagbar_type_xslt = {
" 			\ 'ctagstype' : 'xslt',
" 			\ 'kinds' : [
" 			\ 'v:variables',
" 			\ 't:templates'
" 			\ ]
" 			\}
" }}}
" Comments with vim-commentary {{{
"
" commentary maps, since it is loaded lazily
map  gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary<Plug>CommentaryLine

"}}}
" Map File Exploring to Ranger and Dirvish {{{

map <leader>r :call OpenRanger()<CR>
let g:loaded_netrwPlugin = 1
" nnoremap <silent> <F9> :ProjectRootExe Dirvish<cr>
"autocmd User ProjectionistActivate silent! call snippet#InsertSkeleton()
" nnoremap <leader>d :Dirvish %:p:h<CR>

"}}}
" Sessions with startify  {{{
" What not to save in sessions:
" set sessionoptions-=options  neovim default
silent! call MakeDirIfNoExists(expand($VARPATH . '/session'))
let g:startify_session_dir = expand($VARPATH . '/session')
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
" let g:prosession_dir = expand($VARPATH . '/session')
" }}}
" Linters and Checkers with Accio" {{{
" <F8> sav and run checker
" ---------------------------------------------------------------------
" Accio
" ----------------------------------------------------------------------
" autocmd BufWrite <buffer> Accio ["xqm"]

let g:accio_create_empty_quickfix = 1
let g:accio_auto_copen = 0 "automatically open quick list
let g:accio_update_interval = 250

" Note:  Noah Frederick's  after ... sets text and signs
" @see gf 'after/plugin/accio.vim'
" @see 'Noah Frederick'

" NOTE:
" one filetype can have many compilers
" HTML
" @see 'nvim/ftplugin/html.vim'
" @see 'nvim/compiler/tidy.vim'
" XQUERY
" @see 'nvim/ftplugin/xquery.vim'
" @see 'nvim/compiler/xqm.vim'
" Mapping for quicklist
nnoremap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>q  :call ToggleList("Quickfix List", 'c')<CR>
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
	let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open 3')
  if winnr() != winnr
    wincmd p
  endif
endfunction

" nmap <Leader><Space>o :copen<CR>      " open location window
" nmap <Leader><Space>c :cclose<CR>     " close location window
" nmap <Leader><Space>, :ll<CR>         " go to current error/warning
" nmap <Leader><Space>n :cnext<CR>      " next error/warning
" nmap <Leader><Space>p :cprev<CR>      " previous error/warning
" autocmd! InsertChange,TextChanged *.html update | :Accio [ "tidy", "xmlwf", "xmllint" ]
" }}}
" functions {{{
function! <SID>AutoProjectRootCD()
  try
    if &filetype !=# '' && &filetype != 'help'
     if !empty('b:projectionist')
      execute ":Cd"
    else
     execute ":cd " . system("git rev-parse --show-toplevel")
   endif
    endif
  catch
    " Silently ignore invalid buffers
  endtry
endfunction

" function! OpenRanger()
" 	" let currentPath = expand("%:p:h")
" 	" let projectDir = projectroot#guess()
" 	let tempStr = '/tmp/chosenfile'
" 	let rangerStr = 'ranger'
" 	let rangerStr .= ' --choosedir=' . projectroot#guess() . ' '
" 	let rangerStr .= ' --choosefiles=' .  tempStr . ' '
" 	let rangerStr .= expand("%:p:h")
" 	" let rangerStr .= expand("%:p:h")
" 	let rangerCallback = { 'name': 'ranger' }
" 	function! rangerCallback.on_exit(id, code)
" 		Bclose!
" 		try
" 			if filereadable('/tmp/chosenfile')
" 				exec system('sed -ie "s/ /\\\ /g" /tmp/chosenfile')
" 				exec 'argadd ' . system('cat /tmp/chosenfile | tr "\\n" " "')
" 				exec 'edit ' . system('head -n1 /tmp/chosenfile')
" 				call system('rm /tmp/chosenfile')
" 			endif
" 		endtry
" 	endfunction
" 	enew
" 	call termopen(rangerStr, rangerCallback)
" 	startinsert
" endfunction

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

"
" }}}
" {{{ initialise
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
  autocmd BufEnter * call <SID>AutoProjectRootCD()
  " when entering a buffer look for project root and change dir"
  " our shell commands 'make' etc run from project root
  "@see https://subvisual.co/blog/posts/135-super-powered-vim-part-iii-skeletons/
   " autocmd User ProjectionistActivate silent! call <SID>ProjectActivate()
   " autocmd BufNewFile * silent! call snippet#insert_skeleton()

augroup END
" }}}
"
" command! -register DefaultWorkspace call DefaultWorkspace()
