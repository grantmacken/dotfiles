let g:asyncomplete_log_file = expand('$CACHEPATH/asyncomplete.log')
let g:asyncomplete_autcompletion_delay = 100 " default
let g:asyncomplete_auto_popup = 1            " default
let g:asyncomplete_enable_default_mappings = 0
let g:asyncomplete_remove_duplicates = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
imap <F2> <Plug>(asyncomplete_force_refresh)

let g:UltiSnipsListSnippets = "<C-E>"
let g:UltiSnipsExpandTrigger = "<C-e>"
let g:UltiSnipsJumpForwardTrigger = "<Right>"
let g:UltiSnipsJumpBackwardTrigger = "<Left>"


" let g:asyncomplete_enable_for_all = 1

