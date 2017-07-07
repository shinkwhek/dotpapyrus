set encoding=utf-8
set fileencodings=utf-8

"dein Scripts-----------------------------

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle//repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundle/')
  call dein#begin('~/.vim/bundle/')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundle//repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('w0ng/vim-hybrid')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/vinarise.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('mattn/emmet-vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
syntax on
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------


set laststatus=2
set background=dark
colorscheme hybrid

" ==== ==== neocomplete ==== ====
let g:neocomplete#enable_at_startup = 1


" ==== ==== ==== BASIC ==== ==== ====
" indent
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" delete key
set backspace=indent,eol,start

" key
inoremap <silent> jj <ESC>

" for OCaml
" ---- ocp-indent
set rtp^="/home/vagrant/.opam/system/share/ocp-indent/vim"
" ---- merlin
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
