" if !exists('g:loaded_accio')
"   finish
" endif
let g:neoformat_try_formatprg = 1
let g:neoformat_basic_format_align = 1" Enable alignment
let g:neoformat_basic_format_retab = 1" Enable tab to spaces conversion
let g:neoformat_basic_format_trim = 1"  Enable trimmming of trailing whitespace
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END
