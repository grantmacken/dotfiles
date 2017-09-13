let s:save_cpo = &cpoptions
set cpoptions&vim

" https://github.com/romainl/vim-qf
" TODO add some more from above
"
" text wrapping is pretty much useless in the quickfix window
setlocal nowrap
" relative line numbers don't make much sense either
" but absolute numbers do
setlocal norelativenumber
setlocal nonumber

" we don't want quickfix buffers to pop up when doing :bn or :bp
set nobuflisted

" are we in a location list or a quickfix list?
let b:isLoc = len(getloclist(0)) > 0 ? 1 : 0

" force the quickfix window to be opened at the bottom
" of the screen and take the full width
wincmd J
autocmd BufEnter <buffer> wincmd J

" nnoremap <silent><buffer><nowait> s <C-W><CR><C-W>p<C-W>J<C-W>p
" nnoremap <silent><buffer><nowait> v <C-W><CR><C-W>L<C-W>p<C-W>J<C-W>p
" nnoremap <silent><buffer><nowait> t <C-W><CR><C-W>T

" hit q to quit
nnoremap <silent><buffer><nowait> q :call <SID>CloseQuickfix()<CR>

autocmd BufEnter <buffer> call s:AdjustWindowHeight(1, 5)

function! s:CloseQuickfix()
    redir => buffers
    silent ls
    redir END

    let bufnr = bufnr("%")
    for buf in split(buffers, "\n")
        if (buf =~# '^\s*'.bufnr)
            let close = (buf =~# '\[Quickfix List\]' ? "cclose" : "lclose")
            execute close
            return
        endif
    endfor
endfunction

function! s:AdjustWindowHeight(minheight, maxheight)
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

let &cpoptions = s:save_cpo
unlet s:save_cpo
