"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.vim/bundles')
  call dein#begin('~/.vim/bundles')

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/bundles/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('w0ng/vim-hybrid')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/vinarise.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('mattn/emmet-vim')  
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

syntax on
filetype plugin indent on
syntax enable

" ==== ==== Colour Theme ==== ====
set background=dark
colorscheme hybrid

" ==== ==== neocomplete ==== ====
let g:neocomplete#enable_at_startup = 1

" ==== ==== ==== BASIC ==== ==== ====
" Encoding
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac

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

" for Rust
" ---- rustfmt
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
" ---- racer
set hidden
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let $RUST_SRC_PATH = "/usr/local/src/rustc-1.5.0/src"
