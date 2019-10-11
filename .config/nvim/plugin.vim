
" ==== ==== ==== Plug setup ==== ==== ====
call plug#begin('~/.vim/plugged')

Plug 'cocopon/iceberg.vim' " Theme
Plug 'Shougo/vinarise.vim' " Binary
Plug 'vim-airline/vim-airline' " Airline
" LanguageClient
Plug 'autozimu/LanguageClient-neovim', { 
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'junegunn/fzf' " Fzf
" Ionide
Plug 'ionide/Ionide-vim', {
      \ 'do':  'make fsautocomplete',
      \ }
Plug 'rust-lang/rust.vim' " Rust
Plug 'racer-rust/vim-racer' " Rust Racer

call plug#end()
" ==== ==== ==== ==== ==== ====

" ---- ---- Theme ---- ----
syntax on
filetype plugin on
filetype indent on
set background=dark
colorscheme iceberg

" ---- ---- F# ---- ----
" workspace
let g:fsharp#automatic_workspace_init = 1 " 0 to disable.
let g:fsharp#workspace_mode_peek_deep_level = 2
let g:fsharp#automatic_reload_workspace = 1 " 0 to disable.
" editor
let g:fsharp#show_signature_on_cursor_move = 1 " 0 to disable.
let g:fsharp#fsi_command = "fsharpi"
" advanced : fsharp show tooltips
if has('nvim') && exists('*nvim_open_win')
  augroup FSharpShowTooltip
    autocmd!
    autocmd CursorHold *.fs,*.fsi,*.fsx call fsharp#showTooltip()
  augroup END
endif