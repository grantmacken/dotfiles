
function! my#asyncomplete#setup()
" SYNTAX
    call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
      \ 'name': 'necosyntax',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
      \ }))

  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options(
        \{
        \ 'name': 'ultisnips',
        \ 'whitelist': ['*'],
        \ 'priority': 1,
        \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
        \}))

  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
        \ 'name': 'buffer',
        \ 'whitelist': ['*'], 
        \ 'blacklist': ['go', 'xquery'],
        \ 'priority': 2,
        \ 'completor': function('asyncomplete#sources#buffer#completor'),
        \}))

  "xQuery refresh pattern 'keyword' or 'QNAME'
  " call asyncomplete#register_source(asyncomplete#sources#xQuery#get_source_options(
  "       \{ 'name': 'xQuery', 'whitelist': ['xquery'], 'priority': 2, 'refresh_pattern': '\(\s\k\+$\|:$\)', 'completor': function('asyncomplete#sources#xQuery#completor'), }))
  "
  " VIM
  call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options(
        \{
        \'name': 'necovim', 
        \'whitelist': ['vim'],
        \'priority': 2,
        \'completor': function('asyncomplete#sources#necovim#completor'),
        \}))

endfunction

