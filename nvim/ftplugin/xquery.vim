let s:save_cpo = &cpoptions
set cpoptions&vim

" NOTES:

"comment blocks always start with a (: and end with a :)
" Works for XQDoc style start comments like (:~ too.
setlocal comments=s1:(:,mb::,ex::)
setlocal commentstring=(:%s:)
setlocal dict+=expand('$VIMPATH/words/xquery.txt')

" from html.vim
if exists("loaded_matchit")
    let b:match_ignorecase = 1
    let b:match_words = '<:>,' .
    \ '(:),' .
    \ '{:},' .
    \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
    \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
    \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
endif

if exists('&ofu')
  setlocal omnifunc=xquerycomplete#CompleteXQuery
endif

augroup xquery 
	autocmd BufWrite <buffer> Accio ["xqm"]
	autocmd CursorHoldI,CursorHold,FocusLost,FocusGained * call lightline#update()
augroup END


let &cpoptions = s:save_cpo
unlet s:save_cpo
