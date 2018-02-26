let g:UltiSnipsSnippetsDir = expand('$DATAPATH/snips')
let g:UltiSnipsSnippetDirectories = [g:UltiSnipsSnippetsDir]
let g:UltiSnipsEditSplit = 'context'

augroup ultisnips_custom
  autocmd!
  " autocmd User ProjectionistActivate silent! call my#snippet#insert_skeleton()
  autocmd BufNewFile * silent! call my#snippet#insert_skeleton()
  autocmd BufEnter * execute "inoremap <silent> "
        \ . g:UltiSnipsExpandTrigger
        \ . " <C-r>=my#snippet#expand_snippet_or_complete_maybe()<CR>"
augroup END
