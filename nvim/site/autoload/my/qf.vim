"""
"File: nvim/site/autoload/my/qf.vim
"GF: nvim/init.vim
"GF: nvim/site/after/ftplugin/qf.vim
" http://vim.wikia.com/wiki/Toggle_to_open_or_close_the_quickfix_window
"
" TODO: convert to lua
function! my#quicklist#getBufferList()
  redir =>l:buflist
  silent! ls!
  redir END
  return l:buflist
endfunction

function! my#quicklist#close()
  let l:buflist = my#quicklist#getBufferList()
  let bufnr = bufnr("%")
  for buf in split(l:buflist, "\n")
    if (buf =~# '^\s*'.bufnr)
      let close = (buf =~# '\[Quickfix List\]' ? "cclose" : "lclose")
      execute close
      return
    endif
  endfor
endfunction

function! my#quicklist#AdjustWindowHeight(minheight, maxheight)
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


function! my#quicklist#toggle(bufname, pfx)
  let l:buflist = my#quicklist#getBufferList()
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

" :h quicklist
" -------------------------
"  on quicklist commands triggers
"  e.g. make

function! my#quicklist#pre()
  " echomsg 'my quicklist pre'
endfunction

function! my#quicklist#post()
  " echomsg 'my quicklist post'
endfunction

" -------------------------
"  on quicklist buffer triggers

function! my#quicklist#filled()
  " echomsg 'my quicklist filled'
endfunction

function! my#quicklist#entered()
  " echomsg 'my quicklist entered'
endfunction
