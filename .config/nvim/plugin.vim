
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
  " Golang
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

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

  highlight! Normal ctermbg=NONE guibg=NONE
  highlight! NonText ctermbg=NONE guibg=NONE
  highlight! LineNr ctermbg=NONE guibg=NONE

  " ---- ---- airline ---- ----
  let g:airline_theme='papercolor'

  " ---- ---- deoplete ---- ----
  let g:deoplete#enable_at_startup = 1

endfunction

" ---- ---- Language Client ---- ----
function! s:languageclient()
  let g:LanguageClient_serverCommands = {
    \ 'cpp': ['clangd'],
    \ 'c': ['clangd'],
    \ 'go': ['gopls'],
    \ 'fsharp': g:fsharp#languageserver_command
    \ }
  " -- -- FSharp
  if has('nvim') && exists('*nvim_open_win')
    set updatetime=1000
    augroup FSharpShowTooltip
      autocmd!
      autocmd CursorHold *.fs,*.fsi,*.fsx call fsharp#showTooltip()
    augroup END
  endif
  let g:fsharp#fsharp_interactive_command = "fsharpi"
endfunction

" ---- ---- vim-go ---- ----
function s:setVimGoOption()
  let g:go_term_mode = "split"
  let g:go_fmt_command = "goimports"
  let g:go_addtags_transform = "camelcase"
  let g:go_metalinter_autosave = 1
  let g:go_auto_type_info = 1
  autocmd FileType go set updatetime = 100
  let g:go_play_open_browser = 0
  let g:go_def_mapping_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
endfunction

" ---- ---- Ionide ---- ----
function s:setLSPShortcuts()
  nnoremap <silent> xd :call LanguageClient#textDocument_definition()<CR>
  nnoremap <silent> xn :call LanguageClient#textDocument_rename()<CR>
  nnoremap <silent> xf :call LanguageClient#textDocument_formatting()<CR>
  nnoremap <silent> xt :call LanguageClient#textDocument_typeDefinition()<CR>
  nnoremap <silent> xr :call LanguageClient#textDocument_references()<CR>
  nnoremap <silent> xh :call LanguageClient#textDocument_hover()<CR>
  nnoremap <silent> xs :call LanguageClient#textDocument_documentSymbol()<CR>
  nnoremap <silent> xa :call LanguageClient#textDocument_codeAction()<CR>
  nnoremap <silent> xx :call LanguageClient_contextMenu()<CR>
endfunction()

" ---- ---- Do ---- ----

call s:setupPlug()

call s:setup()

call s:languageclient()
call s:setLSPShortcuts()

call s:setVimGoOption()
