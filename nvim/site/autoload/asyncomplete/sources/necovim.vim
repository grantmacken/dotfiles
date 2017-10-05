

" NOTES
"  {opt} source options is a dictionary set on call in init.vim
"  then passed to completor func as param
"  dic keys
"  name:
"  events:
"  on_event:
"  refresh_pattern: - if not set defaults to '\k\+$'
"  priority:        - if not set defaults to 0

"
" }
"
"  Shugo calls
"  phase 1: $startcol call to complete position
"  phase 2: $matches  call to gather_candidates

function! asyncomplete#sources#necovim#completor(opt, ctx)
    let l:typed = a:ctx['typed']
    let l:startcol = necovim#get_complete_position(l:typed)
    let l:base = strpart(l:typed, l:startcol)
    let l:tmpmataches = []
    let l:tmpmatches = necovim#gather_candidates(l:typed, l:base)
    " should be able to call a filter here
    " Dictionary: 4 (|v:t_dict|)
    " matches is a list of dictionary items
    " let l:matches = necovim#gather_candidates(l:typed, l:base)
    call asyncomplete#log( a:opt['name'] , a:opt['priority']  )
    " call asyncomplete#log( type( l:matches) )
    " let l:matches =  map(l:words,"{'word':v:val,'dup':1,'icase':1,'menu':'[VIM]'}")
    call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol+1, l:matches)
endfunction



function! asyncomplete#sources#necovim#get_source_options(opts)
   return a:opts
endfunction:w


