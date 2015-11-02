" Mapping
" F toggles
"  distraction free editing of markdown files
map <F12> :Goyo <bar> :Limelight!! <bar> :TogglePencil <CR> :GitGutterEnable<CR>
map <F5> :setlocal spell! spelllang=en_nz<CR>
"map <F12> : Goyo<CRk>:GitGutterEnable<CR>
let mapleader=','

"timeout length for leader key
set timeoutlen=2000

"==============================================================================
" 2. LEADER MAPPINGS
"==============================================================================
" * files  ref" 'menu-files.vim'
" * buffers
" * tabs
" * buffer search

" - VimFilerExplorer [{options}...] [{path}] *:VimFilerExplorer*
" files

nnoremap <silent><Leader>w :update<CR>


" buffers and  tabs
"  https://joshldavis.com/2014/04/05/vim-tab-madness-buffers-vs-tabs/
nnoremap <silent><Leader>b :Unite -silent -quick-match buffer<CR>
nnoremap <leader>bb :BufSurfBack<CR> 
nnoremap <leader>bf :BufSurfForward<CR>
nnoremap <leader>bl :ls<CR>


"nnoremap [unite]e :VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -quit<cr>
" Open filer in project folder.
" nnoremap [unite]p :VimFiler -buffer-name=explorer2 -split -simple -winwidth=35 -toggle -project -quit<cr>

" buffers

" tabs
"nnoremap <silent><Leader>B :Unite -silent tab<CR>

" buffer search
"nnoremap <silent><Leader>f :Unite -silent -no-split -start-insert -auto-preview
"           \ line<CR>
"nnoremap <silent>[menu]8 :UniteWithCursorWord -silent -no-split -auto-preview
"            \ line<CR>

" yankring
"nnoremap <silent><Leader>i :Unite -silent history/yank<CR>

" grep
"nnoremap <silent><Leader>a :Unite -silent -no-quit grep<CR>

" help
"nnoremap <silent> g<C-h> :UniteWithCursorWord -silent help<CR>

" tasks
"nnoremap <silent><Leader>; :Unite -silent -toggle
"            \ grep:%::FIXME\|TODO\|NOTE\|XXX\|COMBAK\|@todo<CR>

" outlines (also ctags)
"nnoremap <silent><Leader>t :Unite -silent -vertical -winwidth=40
"            \ -direction=topleft -toggle outline<CR>

" junk files
"  nnoremap <silent><Leader>d :Unite -silent junkfile/new junkfile<CR>
