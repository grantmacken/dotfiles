" :autocmd BufNewFile * :write
"          ^          ^ ^
"          |          | |
"          |          | The command to run.
"          |          |
"          |          A "pattern" to filter the event.
"          |
"          The "event" to watch for.

augroup proveBuffers
  autocmd! * <buffer>
  autocmd BufWrite <buffer> lua require('my.project').prove()
  " autocmd CursorHold <buffer> lua require('my.util').echom(' - Cursor Hold ')
augroup END
