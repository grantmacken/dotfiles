" filetype settings for vimfiler buffer 
" mapping  overides and additional mappings
setlocal nonumber 
setlocal norelativenumber
nmap <buffer> v      <Plug>(vimfiler_quick_look)
nmap <buffer> p      <Plug>(vimfiler_preview_file) 
" autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
" function! s:vimfiler_settings()
" 	setlocal nonumber norelativenumber

" 	nunmap <buffer> <Space>
" 	nunmap <buffer> <C-l>
" 	nunmap <buffer> <C-j>
" 	nunmap <buffer> gr
" 	nunmap <buffer> -

" 	nnoremap <silent><buffer> gr  :<C-u>Unite grep:<C-R>=<SID>selected()<CR><CR>
" 	nnoremap <silent><buffer> gf  :<C-u>Unite file_rec/async:<C-R>=<SID>selected()<CR><CR>
" 	nnoremap <silent><buffer> gc  :<C-u>call <SID>change_vim_current_dir()<CR>
" 	nnoremap <silent><buffer><expr> sg  vimfiler#do_switch_action('vsplit')
" 	nnoremap <silent><buffer><expr> sv  vimfiler#do_switch_action('split')
" 	nmap <buffer> '      <Plug>(vimfiler_toggle_mark_current_line)
" 	nmap <buffer> v      <Plug>(vimfiler_quick_look)
" 	nmap <buffer> p      <Plug>(vimfiler_preview_file)
" 	nmap <buffer> V      <Plug>(vimfiler_clear_mark_all_lines)
" 	nmap <buffer> i      <Plug>(vimfiler_switch_to_history_directory)
" 	nmap <buffer> <Tab>  <Plug>(vimfiler_switch_to_other_window)
" 	nmap <buffer> <C-r>  <Plug>(vimfiler_redraw_screen)
" endfunction
