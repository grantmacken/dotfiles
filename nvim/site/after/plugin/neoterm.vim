"
"================================================
"    NEOTERM
"================================================
"help neoterm
"@see https://github.com/kassio/neoterm
" :Tnew  " open new termnal
" :T pwd " send cmd to term
" :Tclear "
" :Tclose " close window , buffer still exists so,
" can still send commands to it with :T
"  :T %  " can send special commands
"help cmdline-special
let g:neoterm_size = 10
let g:neoterm_fixedsize = 0
let g:neoterm_keep_term_open = 1
let g:neoterm_autoscroll = 0
let g:neoterm_default_mod = 'botright'
" let g:neoterm_autoinsert = 1

" define a mapping
nnoremap <silent> <leader>t :Tmap
let g:neoterm_automap_keys = '<F5>'
" open a new terminal if none is already running, or reuse an existing terminal
command! -nargs=+ TT Topen | T
nnoremap <silent> <F4> :TT
nnoremap <silent> <F6> :Ttoggle<CR>
nnoremap <silent> <F8> :TREPLSendLine<CR>
vnoremap <silent> <F8> :TREPLSendSelection<CR>
noremap <silent> <F7> :TREPLSendFile<CR>

"typing :make is much too long anyway
" nnoremap <leader>m :TT make<CR>
"
" let g:neoterm_automap_keys = ',tt'
" function! BufferInsertLeaveDo()
"   echo 'Working On: ' . expand('%')
"   update
"   execute  ':Topen | T clear && xQwrapper '  . expand('%')
" endfunction

" augroup myRepl
"   autocmd!
"   autocmd BufWritePost,BufEnter,InsertLeave *.xq call BufferInsertLeaveDo()
" augroup END
