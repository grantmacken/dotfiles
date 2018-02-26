" autoload/my/term.vim - Global helpers for term
" Maintainer:  Grant MacKenzie

function! my#term#preserve(command)
  setlocal lazyredraw
  let l:search=@/

  let l:last_view = winsaveview()
  execute a:command
  call winrestview(l:last_view)

  let @/=l:search
  redraw
  setlocal nolazyredraw
endfunction


