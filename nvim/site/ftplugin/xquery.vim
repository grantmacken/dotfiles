let s:save_cpo = &cpoptions
set cpoptions&vim

" NOTES:

"comment blocks always start with a (: and end with a :)
" Works for XQDoc style start comments like (:~ too.
setlocal comments=s1:(:,mb::,ex::)
setlocal commentstring=(:%s:)
" ~/.config/nvim/words/xqExistFunctions.dict

setlocal dict+=~/.config/nvim/words/xqExistFunctions.dict
setlocal thesaurus+=~/.config/nvim/words/ns-funcs.thesaurus
setlocal complete+=k
setlocal complete+=s
" Temporarily change isk to treat dash - and colon :
" pnd opening arenthesis as part of a keyword
" -- so we can complete xquery modules and functions

setlocal iskeyword +=58
setlocal iskeyword +=-
" to check
" :verbose set iskeyword? 
" to check
" :h complete
"  (default: ".,w,b,u,t")
" ~/.config/nvim/words/ns-funcs.thesaurus
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

" if exists('&ofu')
"   setlocal omnifunc=xquerycomplete#CompleteXQuery
" endif
"
":verbose set iskeyword 
"-
" Temporarily change isk to treat opening peren ( as a word
" so the function dictionary works as intended

function! SetKW()
	setlocal iskeyword +=(
endfunction

function! UnSetKW()
	setlocal iskeyword -=(
endfunction

"	autocmd BufWrite <buffer> Accio ["xqCompile", "xqProve"]
" autocmd BufWrite <buffer> Accio ["xqm"]

augroup xquery 
  autocmd BufWrite <buffer> Accio ["xQcompile"]
  " autocmd CursorHoldI,CursorHold,FocusLost,FocusGained * call lightline#update()
  autocmd InsertEnter * call SetKW()
  autocmd InsertLeave * call UnSetKW()
augroup END


let &cpoptions = s:save_cpo
unlet s:save_cpo
