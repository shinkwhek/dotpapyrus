
" ==== ==== ==== Plug setup ==== ==== ====
function! s:setupPlug()
  call plug#begin('~/.vim/plugged')

  " Theme
  Plug 'NLKNguyen/papercolor-theme'
  " Deoplete
  if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
  endif
  " Binary
  Plug 'Shougo/vinarise.vim'
  " Airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " LanguageClient
  Plug 'autozimu/LanguageClient-neovim', { 
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
  " fzf
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  " Ionide
  Plug 'ionide/Ionide-vim', {
        \ 'do':  'make fsautocomplete',
        \ }
  " Rust
  Plug 'rust-lang/rust.vim'
  " Rust Racer
  Plug 'racer-rust/vim-racer'
  " SATySFi
  Plug 'qnighy/satysfi.vim'

  call plug#end()
endfunction
" ==== ==== ==== ==== ==== ====

function! s:setup()
  " ---- ---- Theme ---- ----
  syntax on
  filetype plugin on
  filetype indent on
  set t_Co=256   " This is may or may not needed.
  set background=light
  colorscheme PaperColor

  " ---- ---- airline ---- ----
  let g:airline_theme='papercolor'

  " ---- ---- deoplete ---- ----
  let g:deoplete#enable_at_startup = 1

endfunction

" ---- ---- Language Client ---- ----
function! s:languageclient()
  let g:LanguageClient_serverCommands = {
    \ 'fsharp': g:fsharp#languageserver_command
    \ }
  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  " Or map each action separately
  nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
  if has('nvim') && exists('*nvim_open_win')
    set updatetime=1000
    augroup FSharpShowTooltip
      autocmd!
      autocmd CursorHold *.fs,*.fsi,*.fsx call fsharp#showTooltip()
    augroup END
  endif
  let g:fsharp#fsharp_interactive_command = "fsharpi"
endfunction

" ---- ---- Do ---- ----

call s:setupPlug()

call s:setup()

call s:languageclient()
