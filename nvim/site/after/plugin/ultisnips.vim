


"@see nvim/site/autoload/my/asyncomplete.vim
"@see nvim/site/after/plugin/asyncomplete.vim
"@see nvim/site/autoload/my/snippet.vim

" if !exists("g:did_plugin_ultisnips")
"    finish
" endif

" NOTE: works with asyncomplete
" after <ENTER>
" <CNTRL><e> will expand


let g:UltiSnipsSnippetsDir = expand('$DATAPATH/snips')
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
let g:UltiSnipsEditSplit = 'context'
let g:UltiSnipsListSnippets = "<C-E>"
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<Right>"
let g:UltiSnipsJumpBackwardTrigger = "<Left>"


augroup ultisnips_custom
  autocmd!
  " autocmd User ProjectionistActivate silent! call my#snippet#insert_skeleton()
  autocmd BufNewFile * silent! call my#snippet#insert_skeleton()
  autocmd BufEnter * execute "inoremap <silent> "
        \ . g:UltiSnipsExpandTrigger
        \ . " <C-r>=my#snippet#expand_snippet_or_complete_maybe()<CR>"
augroup END
