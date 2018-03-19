
if !exists('g:asyncomplete_loaded')
    finish
endif

"@see nvim/site/autoload/my/asyncomplete.vim
"@see nvim/site/after/plugin/asyncomplete.vim
"@see nvim/site/autoload/my/snippet.vim
"@see nvim/site/after/plugin/ultisips.vim
" let g:asyncomplete_enable_for_all = 1 " default
let g:asyncomplete_min_chars = 3
" let g:asyncomplete_auto_popup = 1 " default
" let g:asyncomplete_completion_delay = 100 " default
let g:asyncomplete_log_file = expand('$CACHEPATH/asyncomplete.log')
let g:asyncomplete_remove_duplicates = 1
" let g:asyncomplete_smart_completion = 0 " s:has_lua && exists('##TextChangedP')
let g:asyncomplete_default_refresh_pattern = '\(\k\+$\|\.$\|:$\)'
" let g:asyncomplete_normalize_completion_items = 0
" Setting above to true may slow/hang vim especially on slow are sources 
" use asyncomplete_force_refersh to retrive the latest autocomplete results instead
let g:asyncomplete_force_refresh_on_context_changed =  1

" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction

" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ asyncomplete#force_refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
imap <F2> <Plug>(asyncomplete_force_refresh)

