" after/plugin/accio.vim - Accio overrides
" Maintainer: Noah Frederick

if !exists('g:loaded_accio')
  finish
endif

execute "sign define AccioError text=\u276f"
execute "sign define AccioWarning text=\u276f"

highlight! link AccioErrorSign ErrorMsg
highlight! link AccioWarningSign WarningMsg

augroup init_accio
  autocmd!
  autocmd BufWritePost * if exists("b:accio") | call accio#accio(b:accio) | endif
augroup END

