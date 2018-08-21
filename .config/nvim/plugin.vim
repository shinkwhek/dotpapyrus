
" ---- ---- ---- Dein setup ---- ---- ---- "
if !isdirectory(expand("~/.cache/dein"))
    :! curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh && sh /tmp/installer.sh ~/.cache/dein
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein')

  call dein#add('Shougo/denite.nvim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('Shougo/vinarise.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('mattn/emmet-vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('racer-rust/vim-racer')
  call dein#add('fsharp/vim-fsharp')

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
" ---- ---- ---- ---- ---- ---- ---- ---- "

" ==== ==== Colour Theme ==== ====
syntax on
filetype plugin on
filetype indent on
syntax on

set background=dark
colorscheme iceberg

" ==== ==== denite ==== ====
nnoremap <C-p> :<C-u>Denite -path=<c-r>=expand("%:p:h")<cr> file_rec<CR>


" ==== ==== deoplete ==== ====
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
      \'ignore_case': v:true,
      \ })
call deoplete#custom#option('keyword_patterns', {
      \ '_': '[a-zA-Z_]\k*',
\})

" ==== ==== Rust Racer ==== ====
set hidden
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let g:racer_experimental_completer = 1

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" ==== ==== Rust rustfmt ==== ====
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'

" ==== ==== F# ==== ====
" fly check
let g:fsharp_only_check_errors_on_write = 1
let g:fsharpbinding_debug = 1

