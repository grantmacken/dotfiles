" Cursor configuration {{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[2 q"
"}}}
" Respect XDG {{{
if exists("$XDG_CONFIG_HOME")
	let $VIMPATH=expand('$XDG_CONFIG_HOME/nvim')
	let $VARPATH=expand('$XDG_CACHE_HOME/nvim')
else
	let $VIMPATH=expand('$HOME/.config/nvim')
	let $VARPATH=expand('$HOME/.cache/nvim')
endif
" }}}
" Ensure directory "{{{
silent! call MakeDirIfNoExists('$VARPATH/backup')
silent! call MakeDirIfNoExists('$VARPATH/session')
silent! call MakeDirIfNoExists('$VARPATH/logs')
silent! call MakeDirIfNoExists('$VARPATH/tags')

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
"Plug 'justinmk/vim-dirvish'
" Plug 'benekastah/neomake'			" linting
Plug 'pgdouyon/vim-accio'
Plug 'janko-m/vim-test'				" testing
" Plug 'Chiel92/vim-autoformat'	" formating TODO: https://github.com/Chiel92/vim-autoformat
Plug 'simnalamburt/vim-mundo'	" history
Plug 'noahfrederick/vim-skeleton'
Plug 'christoomey/vim-tmux-runner'
Plug 'szw/vim-maximizer' " zoom vim window
" projects git gists and github
Plug 'dbakker/vim-projectroot' "cwd to projectroot for opened project files
Plug 'lambdalisue/vim-gista'
Plug 'lambdalisue/vim-gita'
Plug 'airblade/vim-gitgutter'
" edit
Plug 'junegunn/vim-easy-align' " https://github.com/junegunn/vim-easy-align
Plug 'Raimondi/delimitMate' " https://github.com/Raimondi/delimitMate
Plug 'tpope/vim-commentary', { 'on': ['<Plug>Commentary', '<Plug>CommentaryLine', '<Plug>ChangeCommentary'] }
Plug 'sickill/vim-pasta'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'cazador481/fakeclip.neovim'
Plug 'rbgrouleff/bclose.vim' "delete buffer without closing window
" tags
"Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
" completion and snippets
" Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim' "
Plug 'Shougo/neco-syntax' "deoplete syntax source drop in replacement for  autoload/syntaxcomplete.vim
Plug 'ujihisa/neco-look' "deoplete spelling source ... word completion with 'look' command ref man look
Plug 'Shougo/neoinclude.vim' "deoplete file/include source and extends tag source
Plug 'Shougo/neco-vim'  "deoplete source foe vim


" Plug 'Konfekt/FastFold' recomended Shougo plugin 
" Plug 'Shougo/echodoc'  " recomended plugin .. to look at function auguments 
" Visual
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/seoul256.vim'
Plug 'itchyny/lightline.vim' " will call gita for git updates
Plug 'cocopon/lightline-hybrid.vim'
Plug 'shinchu/lightline-seoul256.vim'
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
" XQUERY 
Plug 'vim-scripts/XQuery-indentomnicompleteftplugin' " might have to install manually
call plug#end()
"}}}:
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
" filetype plugin indent on ... Note: vim Plug does this 
" syntax on  ... Note: vim Plug does this
set modeline                 " automatically setting options from modelines
" set report=0                 " Don't report on line changes
" set noerrorbells             " Don't trigger bell on error
" set visualbell t_vb=         " Don't make any faces
" set lazyredraw               " don't redraw while in macros
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
set wildmode=longest,full
set wildignorecase
" }}}
" Tabs and Indents {{{
set textwidth=120   " Text width maximum 120 chars before wrapping
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
syntax enable
set background=dark
" set background=light
set t_Co=256                   " 256 colors for the terminal


let g:seoul256_background = 236
" let g:seoul256_background = 234
colorscheme seoul256
" colorscheme seoul256-light
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
"set complete=.                  " No wins, buffs, tags, include scanning
set nowrap                      " No wrap by default
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
set colorcolumn=120     " Highlight the 120 th character limit

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
"PLUGGED
" Maximize window with vim-maximizer {{{
let g:maximizer_set_default_mapping = 1
let g:maximizer_default_mapping_key = '<F11>'
"nnoremap <silent><F3> :MaximizerToggle<CR>
"vnoremap <silent><F3> :MaximizerToggle<CR>gv
"inoremap <silent><F3> <C-o>:MaximizerToggle<CR>
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
" default mappings
" gcc comment line
" gc comment
" gcu uncomment
" ----------------------------------------------------------------------------
" }}}
" Clipboard with xClip and fakeclip {{{
let g:vim_fakeclip_tmux_plus=1
" }}}
" File Explorer with netrw {{{
"
 map <leader>r :call OpenRanger()<CR>
let g:netrw_winsize = -28
let g:netrw_banner = 0 " Disable banner
let g:netrw_hide = 1 " show not-hidden files by default
let g:netrw_liststyle=3 " tree view
let g:netrw_sort_sequence = '[\/]$,*'
let g:netrw_browse_split = 4
let g:netrw_altv = 1
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
" Linters with neomake {{{
" neomake notes:  :ll #n  goto eror number
"let g:neomake_verbose=0
"let g:neomake_logfile = expand('$VARPATH/logs/error.log')
"let g:neomake_warning_sign = {
"			\ 'text': '▕',
"			\ 'texthl': 'WarningMsg',
"			\ }
"let g:neomake_error_sign = {
"			\ 'text': '░',
"			\ 'texthl': 'ErrorMsg',
"			\ }

" neomake MAKERS
" --------------
"  with HTML use tidy
" overide tidy defaults http://www.html-tidy.org/
" --gnu-emacs yes'output format that includes the file name
"let g:neomake_html_tidy_args = [
"      \ '--quiet', 1 ,
"			\ '--input-encoding', 'utf8',
"			\ '--show-errors', 6,
"			\ '--show-warnings', 1,
"			\ '--show-info', 0,
"			\ '--gnu-emacs', 1,
"			\ '--show-body-only', 'auto',
"			\ '--doctype', 'omit']

"let g:neomake_html_tidy_errorformat = '%A%f:%l:%c: Warning: %m'
"
" \ 'mapexpr': 'substitute(v:val, ".tasks/modules.mk:56:.....", "", "g")',
"\ 'errorformat': 'xq stderr: .tasks/modules.mk:56: *** %f:%l:%c: %m',
" with xQuery use make
"
"\ 'mapexpr': 'substitute(v:val, ".tasks/modules.mk:56:.....", "", "g")',

"let g:neomake_xquery_xq_maker = {
"    \ 'exe': 'make',
"    \ 'args': ['modules'],
"		\ 'append_file': 0,
"		\ 'errorformat': '%A%f:%l:%c: %m',
"    \ }

"let g:neomake_xquery_enabled_makers = ['xq']
" ----------------------------------------------------------------------
" Accio
" ----------------------------------------------------------------------

let g:accio_create_empty_quickfix = 0
let g:accio_update_interval = 250
execute "sign define AccioError text=\u276f"
execute "sign define AccioWarning text=\u276f"

"highlight! link AccioErrorSign SyntasticErrorSign
"highlight! link AccioWarningSign SyntasticErrorSign

augroup init_accio
  autocmd!
  autocmd BufWritePost * if exists("b:accio") | call accio#accio(b:accio) | endif
augroup END

" autocmd! Filetype xquery setlocal makeprg=make\ modules\ %
"autocmd! BufWritePost *.xqm  Neomake xq

" autocmd! InsertChange,TextChanged *.html update | :Accio [ "tidy", "xmlwf", "xmllint" ]
"let g:neomake_open_list = 2 " automaically open location list 
" }}}
" Autocompletion with deoplete and ultisnips {{{
" let g:SuperTabDefaultCompletionType = '<C-n>'
" set completeopt=menuone,preview " Show preview and menu even for one item
set completeopt+=noinsert       " auto select feature like neocomplete
set completeopt+=noselect
" set g:context_filetype#same_filetypes
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_completion_start_length = 3

" Define keyword.
"  Default the tern foldtextlength 
" <C-h>, <BS>: close popup and delete backword char.
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
" inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function() abort
"   return deoplete#mappings#close_popup() . "\<CR>"
" endfunction

if !exists('g:deoplete#keyword_patterns')
	let g:deoplete#keyword_patterns = {}
endif

let g:deoplete#keyword_patterns['default'] = '\h\w*'

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" sources: 
" Note: come with default sources
" buffer	    It collects keywords from current buffer and the buffers which have same 'filetype'.
" member	    It collects members from cur:rent buffer.
" tag		      It collects keywords from |ctags| files
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
let g:deoplete#sources = {}
let g:deoplete#sources._ = ['buffer', 'member', 'tag', 'file', 'dictionary', 'syntax', 'look', 'file/include' ]  " '_'  value is used for default filetypes
let g:deoplete#sources.html = ['ultisnips', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.javascript = [ 'ternjs', 'ultisnips', 'buffer', 'tag']  " set values for each filetype
let g:deoplete#sources.vim = ['vim', 'buffer', 'tag']  " set values for each filetype
" let g:deoplete#disable_auto_complete = 1
"autocmd,CompleteDone * if pumvisible() == 0 | pclose | endif
" NOTE: avoiding omnifuncs, instead rely on deoplete sources
" omnifuncs
" augroup omnifuncs
"   autocmd!
"   autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"   autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"   autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"  " autocmd FileType javascript setlocal omnifunc=jspc#omni
"   autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"   autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"   autocmd FileType xquery setlocal omnifunc=xquerycomplete#CompleteXQuery
" augroup end

" tern
" if exists('g:plugs["tern_for_vim"]')
"   let g:tern_show_argument_hints = 'on_hold'
"   let g:tern_show_signature_in_pum = 1

"   autocmd FileType javascript setlocal omnifunc=tern#Complete


" endif
"settup SyntaxComplete for every filetype that does not already have a language specific OMNI script
  " if has("autocmd") && exists("+omnifunc")
	" autocmd Filetype *
		    " \	if &omnifunc == "" |
		    " \		setlocal omnifunc=syntaxcomplete#Complete |
		    " \	endif
  "   endif
"===============================================================================
" UltiSnips
"===============================================================================
let g:UltiSnipsListSnippets = "<C-g><tab>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetsDir = split(&runtimepath, ',')[0] . '/snips'
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]

" Make UltiSnips works nicely with YCM
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" UltiSnips config
" inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" }}}
" Status and Tabbar with lightline {{{
" These are the basic settings to get the font to work (required):
" https://github.com/powerline/fonts
" set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 14
" set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 16
" set encoding=utf-8
" required if using https://github.com/bling/vim-airline
" let g:airline_powerline_fonts=1
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
" Editing Saving and Quiting {{{
nnoremap <leader>ep :ProjectRootCD<cr>:e<space>
" Saving
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
" gita
nnoremap <Leader>g<Space> :Gita<Space>
nnoremap <Leader>gs :Gita status<CR>
nnoremap <Leader>gc :Gita commit<CR>
" Moving forward and back with prefixes  '[' ']' {{{
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
" only within current project
nnoremap <silent> [p :ProjectBufPrev<cr>
nnoremap <silent> ]p :ProjectBufNext<cr>
nnoremap <silent> [P :ProjectBufFirst<cr>
nnoremap <silent> ]P :ProjectBufLast<cr>
" mF to mark file
nnoremap <silent> ]f :ProjectBufNext 'F<cr>
nnoremap <silent> [f :ProjectBufPrev 'F<cr>
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

augroup vimenter
    autocmd!
    autocmd VimEnter * silent setlocal cursorline
	augroup END

augroup qf
    autocmd!
    autocmd QuickFixCmdPost grep,make,grepadd,vimgrep,vimgrepadd,cscope,cfile,cgetfile,caddfile,helpgrep cwindow
    autocmd QuickFixCmdPost lgrep,lmake,lgrepadd,lvimgrep,lvimgrepadd,lcscope,lfile,lgetfile,laddfile lwindow
	augroup END

augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
	augroup END

augroup vimrc
	autocmd!
"	autocmd BufWritePost $MYVIMRC nested source $MYVIMR
" autocmd BufEnter * :syntax sync fromstart
"
  autocmd BufNewFile,BufRead .env.* setfiletype sh
	autocmd BufNewFile,BufRead *.snippets set filetype=snippets

	autocmd BufEnter * call <SID>AutoProjectRootCD()
  " Included syntax
  "au FileType,ColorScheme * call <SID>file_type_handler()
  " Automatic rename of tmux window
  if exists('$TMUX') && !exists('$NORENAME')
    au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
    au VimLeave * call system('tmux set-window automatic-rename on')
  endif
augroup END
" }}}
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

"
" }}}
" last line is modeline
" vim:foldmethod=marker:foldlevel=0
