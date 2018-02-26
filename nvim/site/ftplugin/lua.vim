
" * only run on file save
" * use the quickfix only
let b:ale_lint_on_text_changed = 'never'
let b:ale_lint_on_enter = 0
let b:ale_set_loclist = 1
let b:ale_set_quickfix = 0
let b:ale_echo_cursor = 1
let b:ale_linters = ['luacheck']

" special pattern buffers
" :h Buffer-local
"  buffer-local commands
" example
" h: CursorHold-
" h: BufferWrite
" h: BufWinEnter
" h: BufWinLeave  etc
" h autocmd-events-abc

" TERMINAL EVENTS
"  TermOpen  terminal buffer is starting
"  TermClose terminal buffer ends
"  TermChanged value of term changed


augroup luaBuffers
  autocmd! * <buffer>
  autocmd BufWrite <buffer> lua require('my.project').prove()
  " autocmd CursorHold <buffer> lua require('my.util').echom(' - Cursor Hold ')
augroup END

