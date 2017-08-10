let s:save_cpo = &cpoptions
set cpoptions&vim

augroup html
    autocmd BufWrite <buffer> Accio ["tidy"]
augroup END

let &cpoptions = s:save_cpo
unlet s:save_cpo
