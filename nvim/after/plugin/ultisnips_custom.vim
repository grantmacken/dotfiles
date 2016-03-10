" ultisnips_custom.vim - Custom UltiSnips settings
" Maintainer:   Noah Frederick
" https://noahfrederick.com/log/vim-templates-with-ultisnips-and-projectionist/
" after/plugin/ultsnips_custom.vim

"if exists(":SkelEdit") || !exists("g:UltiSnipsExpandTrigger")
"  finish
"endif

augroup ultisnips_custom
  autocmd!
  autocmd BufNewFile * silent! call snippet#insert_skeleton()
augroup END

