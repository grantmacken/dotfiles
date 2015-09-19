" https://github.com/terryma/dotfiles/blob/master/.vimrc
" https://github.com/joedicastro/dotfiles/tree/master/vim

" NoCompatible
set nocp

let g:vim_home = get(g:, 'vim_home', expand('~/.vim/'))
let g:vim_setup = get(g:, 'vim_setup', expand('~/.vim/setup'))

exec 'source' g:vim_setup.'/plugins.vim'
exec 'source' g:vim_setup.'/config.vim'

" Set at the end to work around 'exrc'
set secure
