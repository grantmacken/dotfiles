
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
"
" let s:words = {}
" let s:last_word = ''

" NOTE:
" xQuery refesh patterns
" force refresh of cache when
" '\k'  keyword as defined by xQuery iskeyword
" ':' QName pattern prefix:name
" '"' literal
function! asyncomplete#sources#xQuery#get_source_options(opts)
    return extend(extend({}, a:opts), {
            \ 'refresh_pattern': '\(\k\+$\)\|\(:$\)',
            \ })
endfunction

" NOTES:
" https://github.com/prabirshrestha/asyncomplete.vim/pull/3
" completor calculates 'start col' then caches result 'matches'
" cache is refreshed by 'asyncomplete_force_refresh'
" Since completion is only called when we have at least one 
" character or whenever force completion is requested which 
" includes even zero characters ...
"  the min keyword length should not be checked by the sources. 
"  If the completor function is 
" called the source should just provide the completion at the 
" position.
"
function! asyncomplete#sources#xQuery#completor(opt, ctx) abort
  " given 'boundary' the user typed xxx
  let l:startcol = luaeval("require('matches').getStartCol()")
   if l:startcol is v:null
     return
  endif
  let l:matches = luaeval("require('matches').getMatches()")
  call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol, l:matches, 1 )
endfunction

