"""
"File: nvim/site/autoload/my/qf.vim
"GF: nvim/init.vim
"GF: nvim/site/after/ftplugin/qf.vim
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
"
" TODO: convert to lua
function! my#qf#getBufferList()
  redir =>l:buflist
  silent! ls!
  redir END
  return l:buflist
endfunction



function! my#qf#AdjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction
" https://gist.github.com/juanpabloaj/5845848


function! my#qf#toggle(bufname, pfx)
  let l:buflist = my#qf#getBufferList()
  for l:bufnum in map(filter(split(l:buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(l:bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx ==# 'l' && len(getloclist(0)) == 0
    echohl ErrorMsg
    echo 'Location List is Empty.'
    return
  endif
  let l:winnr = winnr()
  exec(a:pfx.'open 10')
  if winnr() != l:winnr
    wincmd p
  endif
endfunction

" :h qf
" -------------------------
"  on qf commands triggers
"  e.g. make

function! my#qf#pre()
  " echomsg 'my qf pre'
endfunction

function! my#qf#post()
  " echomsg 'my qf post'
endfunction

" -------------------------
"  on qf buffer triggers

function! my#qf#filled()
  " echomsg 'my qf filled'
endfunction

function! my#qf#entered()
  " echomsg 'my qf entered'
endfunction
