"    https://github.com/terryma/dotfiles/blob/master/.vimrc " custom unite settings
" 
" mappings 
nmap <buffer> <ESC> <Plug>(unite_insert_enter)
imap <buffer> <ESC> <Plug>(unite_exit)
imap <buffer> q     <Plug>(unite_exit)
imap <buffer> jj    <Plug>(unite_insert_leave)   
nmap <buffer> e     <Plug>(unite_do_default_action)  
nmap <buffer> '     <Plug>(unite_toggle_mark_current_candidate)
nmap <buffer> x     <Plug>(unite_quick_match_jump)
imap <buffer> <C-j> <Plug>(unite_select_next_line)
imap <buffer> <C-j> <Plug>(unite_insert_leave)
nmap <buffer> <C-j> <Plug>(unite_loop_cursor_down)
nmap <buffer> <C-k> <Plug>(unite_loop_cursor_up)
imap <buffer> <C-w> <Plug>(unite_delete_backward_word)
imap <buffer> <C-u> <Plug>(unite_delete_backward_path)
imap <buffer> '     <Plug>(unite_quick_match_default_action)
nmap <buffer> '     <Plug>(unite_quick_match_default_action)
nmap <buffer> <C-r> <Plug>(unite_redraw)
imap <buffer> <C-r> <Plug>(unite_redraw)

nmap <buffer> <C-g>         <Plug>(unite_print_candidate)

nmap <silent><buffer><expr> sv unite#do_action('split')
nmap <silent><buffer><expr> sg unite#do_action('vsplit')
nmap <silent><buffer><expr> st unite#do_action('tabopen')
