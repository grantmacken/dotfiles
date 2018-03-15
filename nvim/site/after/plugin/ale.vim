" :h ale
" map ]a <Plug>(ale_next_wrap)
" nmap [a <Plug>(ale_previous_wrap)

if !exists('g:loaded_ale_dont_use_this_in_other_plugins_please')
    finish
endif

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_echo_cursor = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 0
