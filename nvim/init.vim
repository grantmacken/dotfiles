" XDG Paths {{{

function! MakeDirIfNoExists(path)
		if !isdirectory(expand(a:path))
				call mkdir(expand(a:path), "p")
		endif
endfunction

if exists("$XDG_CONFIG_HOME")
	let $VIMPATH=expand('$XDG_CONFIG_HOME/nvim')
	let $VARPATH=expand('$XDG_CACHE_HOME/nvim')
else
	let $VIMPATH=expand('$HOME/.config/nvim')
	let $VARPATH=expand('$HOME/.cache/nvim')
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

" terminal 

" temp mappings top of file
nnoremap <silent> <F3>  :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
" }}}
" Add In Plugings {{{

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin(expand('$VIMPATH/plugged'))
" File and Project Management
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-projectionist'
" Plug 'tpope/vim-fugitive'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-eunuch'
Plug 'dbakker/vim-projectroot' "cwd to projectroot for opened project files
" git gists and github
" Plug 'lambdalisue/vim-gista' " not yet compatible with neomake
"
Plug 'airblade/vim-gitgutter'
Plug 'jreybert/vimagit'
" Plugt'lambdalisue/vim-gita'
" Code Compile Test. Async Checking and Linting Builds
Plug 'pgdouyon/vim-accio'
" Code Completion and Snippets
Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/neco-syntax' "deoplete syntax source drop in replacement for  autoload/syntaxcomplete.vim
Plug 'ujihisa/neco-look' "deoplete spelling source ... word completion with 'look' command ref man look
Plug 'Shougo/neoinclude.vim' "deoplete file/include source and extends tag source
Plug 'Shougo/neco-vim'  "deoplete source for vim
Plug 'Konfekt/FastFold' "recomended Shougo plugin
Plug 'wellle/tmux-complete.vim' " https://github.com/wellle/tmux-complete.vim

Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" Plug 'benekastah/neomake'			" linting
" Plug 'janko-m/vim-test'				" do everthing with accio
" Plug 'Chiel92/vim-autoformat'	" formating TODO: https://github.com/Chiel92/vim-autoformat
Plug 'simnalamburt/vim-mundo'	" history
" Plug 'christoomey/vim-tmux-runner'
Plug 'rbgrouleff/bclose.vim' "delete buffer without closing window
Plug 'szw/vim-maximizer' " zoom vim window
" Editing Code manipulation
Plug 'unblevable/quick-scope' "https://github.com/unblevable/quick-scope
" Plug 'junegunn/vim-easy-align' " https://github.com/junegunn/vim-easy-align
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
Plug 'junegunn/seoul256.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim' " will call gita for git updates
" Plug 'cocopon/lightline-hybrid.vim'
" Plug 'bling/vim-bufferline'  TODO
"Plug 'shinchu/lightline-seoul256.vim' " now in lightline colorschemes
Plug 'edkolev/tmuxline.vim'
" Plug 'itchyny/vim-gitbranch'
" writing
Plug 'reedes/vim-pencil'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " distraction-free writing
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' } " focus tool. Good for presentating with vim
" Plug 'ron89/thesaurus_query.vim' TODO https://github.com/Ron89/thesaurus_query.vim
" sessions:
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession' " each git project has associated vim session
" language-specific plugins
" JavaScript:  https://davidosomething.com/blog/vim-for-javascript/
Plug 'othree/yajs.vim', { 'for': 'javascript' } " SYNTAX object/method data comes from Mozilla's WebIDL
" Plug 'othree/es.next.syntax.vim'
" Plug 'othree/javascript-libraries-syntax.vim'
Plug 'gavocanov/vim-js-indent' " INDENT
"Plug 'heavenshell/vim-jsdoc' "  jsdocs  https://github.com/heavenshell/vim-jsdoc
"Plug 'ternjs/tern_for_vim', { 'do': 'npm install' } " setup tern
Plug 'carlitux/deoplete-ternjs' " COMPLETION: deoplete tern as recomended by Shougo
" Plug 'othree/jspc.vim' ... COMPLETION:  function param completion
" JSON:
Plug 'elzr/vim-json', { 'for': 'json' } " JSON support
" CSS:
Plug 'ap/vim-css-color', { 'for': 'css' } " set the background of hex color values to the color
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' } " CSS3 syntax support
" HTML XML:
Plug 'othree/html5.vim' "HTML 5 with  WAI-ARIA attribute support
Plug 'othree/xml.vim' " close tags while you type
" Plug 'tejr/vim-tmux'
" TMUX:
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux'
" VIM:
Plug 'junegunn/vader.vim' " testing vim plugings -- use for syntax
" XQUERY
"Plug 'vim-scripts/XQuery-indentomnicompleteftplugin' " might have to install manually
call plug#end()

"}}}
" Editor UI Appearance {{{
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " Have thin cursor shap in insert mode
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1 " enable true color support

set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTI     " Shorten messages and don't show intro
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=2     " Keep at least 2 lines left/right
set number              " Show line numbers
set relativenumber      " Use relative instead of absolute line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters

set wildmode=longest,full
set wildignorecase

set showtabline=2       " Always show the tabs line
set tabpagemax=30       " Maximum number of tab pages

set previewheight=8     " Completion preview height
set pumheight=20        " Pop-up menu's line height
set helpheight=12       " Minimum help window height

set noshowcmd           " Don't show command in status line
set cmdheight=2         " Height of the command line
set cmdwinheight=5      " Command-line lines

" nvim default set laststatus=2   Always show a status line
set colorcolumn=120     " Highlight the 120 th character limit

" Changing characters to fill special ui elements
set showbreak=↪
" set fillchars=vert:│,fold:─
" nvim defaults set listchars=tab:\⋮\ ,extends:⟫,precedes:⟪,nbsp:.,trail:·
"}}}
" Colorscheme {{{

" syntax enable
set background=dark
set t_Co=256                   " 256 colors for the terminal

let g:seoul256_background = 236
colorscheme seoul256

" execute ':highlight Pmenu ctermbg=DarkGrey'
" 
highlight Pmenu ctermbg=DarkGrey
highlight TermCursor ctermfg=red guifg=red

" }}}
" Tabs and Indents {{{

set textwidth=120   " Text width maximum 120 chars before wrapping
set expandtab       " expand tabs to spaces except for Make see runtime
set softtabstop=2   " While performing editing operations
" /usr/share/nvim/runtime/ftplugin/make.vim
set nosmarttab
set tabstop=2       " The number of spaces a tab is
set shiftwidth=2    " Number of spaces to use in auto(indent)
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'

" }}}
" Files and Directories {{{
"set nobackup
"set nowritebackup
set noswapfile
set nobackup
set undofile 
set undolevels=5000
set undoreload=10000
let g:undo_dir=expand($VARPATH . '/undo')
silent! call MakeDirIfNoExists( g:undo_dir )
" save everything here
" exec "set backupdir=" . g:undo_dir
exec "set undodir=" . g:undo_dir

" http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-45841328i
" set autowriteall  "Save buffer automatically when changing files
" set autoread      "Always reload buffer when external changes detected
let g:spell_add=expand($VARPATH . '/spell/en.utf-8.add')
exec "set spellfile=" . g:spell_add
" }}}
" PLUGGED
" Autocompletion with deoplete and ultisnips {{{
"
"complete options
" :h complete
"  (default: ".,w,b,u,t")
"  current buffer, window buffers, unloaded buffers, tags
" NOTE: set for k 
" 
set completeopt+=menuone
set completeopt+=noinsert       " auto select feature like neocomplete
set completeopt+=noselect
" set completeopt+=preview
" set completeopt+=longest

" NOTE: set 
let g:SuperTabDefaultCompletionType = "<c-n>" " Make the tabing on completion menu go from top to bottom
let g:SuperTabClosePreviewOnPopupClose = 1 " Close the preview when completion ends

"===============================================================================
" DEOPLETE
"==============================================================================
" enable at startup
let g:deoplete#enable_at_startup = 1
" disable autocomplete
" let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 3

let g:deoplete#max_menu_width = 120
let g:deoplete#max_abbr_width = 80
"augroup omnifuncs
"	autocmd!
"	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"  " autocmd FileType javascript setlocal omnifunc=jspc#omni
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"   autocmd FileType xquery setlocal omnifunc=xquerycomplete#CompleteXQuery
"augroup end

" sources:
" Note: come with default sources
" buffer	    It collects keywords from current buffer and the buffers which have same 'filetype'.
" member	    It collects members from current buffer.
" tag		      It collects keywords from ctags files
" file	      This source collects keywords from local files.
" omni		    This source collects keywords from 'omnifunc'. Note: It is not asynchronous.
" dictionary	This source collects keywords from 'dictionary'.
" Note: can have external sources :Help deoplete-external-sources
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
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources._ = ['buffer', 'member', 'tag', 'file']

let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary', 'syntax', 'look', 'file/include' ]
" '_'  value is used for default filetypes

let g:deoplete#sources.xquery = ['ultisnips', 'tag', 'syntax']  " set values for each filetype
let g:deoplete#sources.html = ['ultisnips', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.javascript = [ 'ternjs', 'ultisnips', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.vim = ['vim', 'buffer', 'tag']  " set values for each filetype

" Use partial fuzzy matches like YouCompleteMe
call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
"call deoplete#custom#set('_', 'converters', ['converter_remove_paren'])
call deoplete#custom#set('_', 'disabled_syntaxes', ['Comment', 'String'])

" Manual Tag complete
function! g:DeopleteManualTagComplete() abort
  if pumvisible()
    return g:deoplete#mappings#close_popup()
  else
    return g:deoplete#mappings#manual_complete('tag')
  endif
endfunction
"===============================================================================
" UltiSnips
"===============================================================================
" creating and editing snips
nnoremap <silent> <F2>  :UltiSnipsEdit<CR>
let g:UltiSnipsSnippetsDir = split(&runtimepath, ',')[0] . '/snips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
let g:UltiSnipsEditSplit = "vertical"
"https://github.com/simonweil/dotfiles/blob/master/nvimrc
" Don't map any tabs, I'll do it later

let g:UltiSnipsExpandTrigger = '<NOP>'
let g:UltiSnipsJumpForwardTrigger = '<NOP>'
let g:UltiSnipsJumpBackwardTrigger = '<NOP>'
let g:SuperTabMappingForward = '<NOP>'
let g:SuperTabMappingBackward = '<NOP>'
" Don't unmap my mappings
let g:UltiSnipsMappingsToIgnore = [ "SmartTab", "SmartShiftTab" ]

" Make <CR> smart
let g:ulti_expand_res = 0
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
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>

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
inoremap <silent> <tab> <C-R>=g:SmartTab()<cr>
snoremap <silent> <tab> <Esc>:call g:SmartTab()<cr>

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
inoremap <silent> <s-tab> <C-R>=g:SmartShiftTab()<cr>
snoremap <silent> <s-tab> <Esc>:call g:SmartShiftTab()<cr>


" Disable built-in cx-ck to be able to go backward
" inoremap <C-x><C-k> <NOP>

" function! g:UltiSnips_Complete()
"   call UltiSnips#ExpandSnippet()
"   if g:ulti_expand_res == 0
"     if pumvisible()
"       return "\<C-n>"
"     else
"       call UltiSnips#JumpForwards()
"       if g:ulti_jump_forwards_res == 0
"         return "\<TAB>"
"       endif
"     endif
"   endif
"   return ""
" endfunction

" function! g:UltiSnips_Reverse()
"   call UltiSnips#JumpBackwards()
"   if g:ulti_jump_backwards_res == 0
"     return "\<C-P>"
"   endif

"   return ""
" endfunction

" if !exists("g:UltiSnipsJumpForwardTrigger")
"   let g:UltiSnipsJumpForwardTrigger = "<tab>"
" endif

" if !exists("g:UltiSnipsJumpBackwardTrigger")
"   let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
" endif

" " MAPPINGS
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

" " Manually trigger tag autocomplete
" inoremap <silent> <expr> <C-]> DeopleteManualTagComplete()
" " <C-h>, <BS>: close popup and delete backword char
" inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> deoplete#mappings#smart_close_popup()."\<C-h>"
" " insert <TAB> or select next match
" " au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" }}}
" Windows and Buffers
" <F12> open|close terminal
" <F11> Maximize window with vim-maximizer
" <F10> open|closetags window with tagbar
" window  settings {{{
set notitle             " No need for a title
set noequalalways       " Don't resize windows on split or close
set winwidth=30         " Minimum width for current window
set winheight=1         " Minimum height for current window
set splitbelow
set splitright
"}}}
" {{{ terminal buffer
" when in terminal go back to previous window
" https://neovim.io/doc/user/nvim_terminal_emulator.html#nvim-terminal-emulator
tnoremap <F12> <C-\><C-n><C-w><C-p>
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" https://neovim.io/doc/user/options.html#%27term%27
" https://neovim.io/doc/user/autocmd.html#TermClose
" TermChanged, TermClose, TermResponse 

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
    execute ":botright 10 split \| terminal"
  endif
endfunction

map <F12> :call TermEnter()<CR>

" }}}
" maximizer {{{
let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<F11>'
" }}}
" Tags created by universal-ctags and views created with tagbar {{{
" Notes: ctags config
map <F10> :TagbarToggle<CR>
" Note: <leader>'t'  Fuzzy Find
"let g:gutentags_cache_dir = '$VARPATH/tags'
let g:tagbar_type_css = {
			\ 'ctagstype' : 'Css',
			\ 'kinds'     : [
			\ 'c:classes',
			\ 's:selectors',
			\ 'i:identities'
			\ ]
			\ }

let g:tagbar_type_make = {
			\ 'kinds':[
			\ 'm:macros',
			\ 't:targets'
			\ ]
			\}

let g:tagbar_type_markdown = {
			\ 'ctagstype' : 'markdown',
			\ 'kinds' : [
			\ 'h:Heading_L1',
			\ 'i:Heading_L2',
			\ 'k:Heading_L3'
			\ ]
			\ }

let g:tagbar_type_xquery = {
			\ 'ctagstype' : 'xquery',
			\ 'kinds'     : [
			\ 'f:function',
			\ 'v:variable',
			\ 'm:module',
			\ ]
			\ }

let g:tagbar_type_xsd = {
			\ 'ctagstype' : 'XSD',
			\ 'kinds'     : [
			\ 'e:elements',
			\ 'c:complexTypes',
			\ 's:simpleTypes'
			\ ]
			\ }

let g:tagbar_type_xslt = {
			\ 'ctagstype' : 'xslt',
			\ 'kinds' : [
			\ 'v:variables',
			\ 't:templates'
			\ ]
			\}
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
  \ 'ctrl-m': 'edit',
  \ 'ctrl-t': 'tabedit',
  \ 'ctrl-x': 'botright split',
  \ 'ctrl-v':  'vertical botright split' }
"nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>f  :GitFiles<CR>
nnoremap <silent> <Leader>b  :Buffers<CR>
nnoremap <silent> <Leader>t  :Tags<CR>
nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
if executable('ag')
  set grepprg=ag\ --vimgrep
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
" Sessions with obsession and prosession {{{
" What not to save in sessions:
" set sessionoptions-=options  neovim default
silent! call MakeDirIfNoExists(expand($VARPATH . '/session'))
" save everything here

set sessionoptions-=globals
set sessionoptions-=folds
set sessionoptions-=help
let g:prosession_tmux_title = 1
let g:prosession_on_startup = 1
let g:prosession_default_session = 0
let g:prosession_dir = expand($VARPATH . '/session')
" }}}
" Linters and Checkers with Accio
" <F8> sav and run checker
" {{{

" ---------------------------------------------------------------------
" Accio
" ----------------------------------------------------------------------

" autocmd BufWrite <buffer> Accio ["xqm"]

nnoremap <silent> <F8> :Accio ["xqm"]<CR>

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
nnoremap <silent> <F6> :call ToggleList("Quickfix List", 'c')<CR>
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
" Status and Tabbar with lightline {{{

let g:lightline = {}

let g:lightline.colorscheme = 'seoul256'

let g:lightline.active = {
    \ 'right': [ [ 'accio', 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'fileformat', 'fileencoding', 'filetype' ] ] }

let g:lightline.inactive = {
    \ 'left': [ [ 'filename' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ] ] }

let g:lightline.tabline = {
    \ 'left': [ [ 'tabs' ] ],
    \ 'right': [ [ 'close' ] ] }

let g:lightline.tab = {
    \ 'active': [ 'tabnum', 'filename', 'modified' ],
    \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }


let g:lightline.component = {
    \ 'mode': '%{lightline#mode()}',
    \ 'absolutepath': '%F',
    \ 'relativepath': '%f',
    \ 'filename': '%t',
    \ 'modified': '%M',
    \ 'bufnum': '%n',
    \ 'paste': '%{&paste?"PASTE":""}',
    \ 'readonly': '%R',
    \ 'charvalue': '%b',
    \ 'charvaluehex': '%B',
    \ 'fileencoding': '%{strlen(&fenc)?&fenc:&enc}',
    \ 'fileformat': '%{&fileformat}',
    \ 'filetype': '%{strlen(&filetype)?&filetype:"no ft"}',
    \ 'percent': '%3p%%',
    \ 'percentwin': '%P',
    \ 'spell': '%{&spell?&spelllang:"no spell"}',
    \ 'lineinfo': ' %3l:%-2v',
    \ 'line': '%l',
    \ 'column': '%c',
    \ 'close': '%999X X ' }

let g:lightline.component_visible_condition = {
    \ 'modified': '&modified||!&modifiable',
    \ 'readonly': '&readonly',
    \ 'paste': '&paste' }

let g:lightline.component_expand = {
     \ 'accio': 'LightLineErrors',
     \ }

let g:lightline.component_type = {
     \ 'accio': 'error',
     \ }

let g:accio_mode_map = {
			\'mode': 'passive',
			\ 'active_filetypes': ['xquery']
			\}

" let g:lightline.component_function = {
" 		\ 'readonly': 'LightLineReadonly', }

let g:lightline.tab_component_function = {
      \ 'filename': 'lightline#tab#filename',
      \ 'modified': 'lightline#tab#modified',
      \ 'readonly': 'lightline#tab#readonly',
      \ 'tabnum': 'lightline#tab#tabnum' }

let g:lightline.mode_map = {
    \ 'n' : 'NORMAL',
    \ 'i' : 'INSERT',
    \ 'R' : 'REPLACE',
    \ 'v' : 'VISUAL',
    \ 'V' : 'V-LINE',
    \ "\<C-v>": 'V-BLOCK',
    \ 'c' : 'COMMAND',
    \ 's' : 'SELECT',
    \ 'S' : 'S-LINE',
    \ "\<C-s>": 'S-BLOCK',
    \ 't': 'TERMINAL',
    \ '?': '' }

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.tabline_separator = g:lightline.separator
let g:lightline.tabline_subseparator = g:lightline.subseparator

" let g:lightline.enable = {
" 		    \ 'statusline': 1,
" 		    \ 'tabline': 1
" 		    \ }

function! LightLineReadonly()
	return &readonly ? '' : ''
endfunction

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineGitBranch() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('branch') : ''
endfunction " }}}

function! LightLineGitTraffic() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('traffic') : ''
endfunction " }}}

function! LightLineGitStatus() " {{{
  return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
endfunction " }}}

function! LightLineErrors() " {{{
return	exists('*accio#statusline') ? accio#statusline('  %d ', '') : ''
endfunction " }}}

"}}}
" functions {{{ 


function! <SID>AutoProjectRootCD()
	try
		if &ft != 'help'
			ProjectRootCD
		endif
	catch
		" Silently ignore invalid buffers
	endtry
endfunction

function! OpenRanger()
	" let currentPath = expand("%:p:h")
	" let projectDir = projectroot#guess()
	let tempStr = '/tmp/chosenfile'
	let rangerStr = 'ranger'
	let rangerStr .= ' --choosedir=' . projectroot#guess() . ' '
	let rangerStr .= ' --choosefiles=' .  tempStr . ' '
	let rangerStr .= expand("%:p:h")
	" let rangerStr .= expand("%:p:h")
	let rangerCallback = { 'name': 'ranger' }
	function! rangerCallback.on_exit(id, code)
		Bclose!
		try
			if filereadable('/tmp/chosenfile')
				exec system('sed -ie "s/ /\\\ /g" /tmp/chosenfile')
				exec 'argadd ' . system('cat /tmp/chosenfile | tr "\\n" " "')
				exec 'edit ' . system('head -n1 /tmp/chosenfile')
				call system('rm /tmp/chosenfile')
			endif
		endtry
	endfunction
	enew
	call termopen(rangerStr, rangerCallback)
	startinsert
endfunction

function! CreateArticle( file )
	call MakeDirIfNoExists( strftime("content/posts/articles/%Y/%m/%d") )
	execute ':A ' . strftime("content/posts/articles/%Y/%m/%d/") . a:file  . '.md'
endfunction
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
autocmd BufNewFile,BufRead .env.* setfiletype sh
autocmd BufNewFile,BufRead *.snippets set filetype=snippets "add new snippets filetpe
autocmd BufEnter * call <SID>AutoProjectRootCD()
	" when entering a buffer look for project root and change dir"
	" our shell commands 'make' etc run from project root
	" 
autocmd User ProjectionistActivate
		\ if &filetype !=# '' && &filetype !=# 'dirvish' |
		\   for [s:root, s:value] in projectionist#query("framework") |
		\     if index(split(&filetype, '\.'), s:value) < 0 |
		\       let &filetype = join([&filetype, s:value], ".") |
		\     endif |
		\   endfor |
		\ endif
  " Included syntax
	if exists('$TMUX') && !exists('$NORENAME')
		au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
		au VimLeave * call system('tmux set-window automatic-rename on')
	endif
augroup END
" }}}
