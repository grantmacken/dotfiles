
let mapleader=','

"timeout length for leader key
set timeoutlen=2000

"==============================================================================
" 2. LEADER MAPPINGS
"==============================================================================
" * files
" * buffers
" * tabs
" * buffer search


" - VimFilerExplorer [{options}...] [{path}] *:VimFilerExplorer*
" options -no-quit

" files
nnoremap <silent><Leader>m :call UProjectMostRecentlyUsed()<CR>
nnoremap <silent><Leader>o :call UProjectFiles()<CR>
nnoremap <silent><Leader>e :VimFilerExplorer -no-quit -explorer -project -status -find -auto-expand<CR>

"nnoremap [unite]e :VimFilerBufferDir -buffer-name=explorer -split -simple -winwidth=35 -toggle -quit<cr>
" Open filer in project folder.
"nnoremap [unite]p :VimFiler -buffer-name=explorer2 -split -simple -winwidth=35 -toggle -project -quit<cr>






" buffers
nnoremap <silent><Leader>b :Unite -silent buffer<CR>

" tabs
"nnoremap <silent><Leader>B :Unite -silent tab<CR>

" buffer search
"nnoremap <silent><Leader>f :Unite -silent -no-split -start-insert -auto-preview
            \ line<CR>
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
