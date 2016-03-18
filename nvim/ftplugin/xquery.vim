let s:save_cpo = &cpoptions
set cpoptions&vim

augroup xquery 
		autocmd BufWrite <buffer> Accio ["xqModules"]
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
