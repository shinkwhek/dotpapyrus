" author : Shin KAWAHARA
" ---- ---- NOT load for tiny or small ---- ----
if !1 | finish | endif

" ---- ---- Encoding ---- ----
set encoding=UTF-8
set fileencoding=UTF-8
set termencoding=UTF-8

" ---- ---- NOT beep ---- ----
set vb t_vb=

" ---- ---- hightlight search result ---- ----
set hlsearch

" ---- ---- h,l can wrap ---- ----
set whichwrap +=h
set whichwrap +=l

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible

set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set nobackup		" keep a backup file (restore to previous version)
  set undofile		" keep an undo file (undo changes after closing)
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

map Q gq

inoremap <C-U> <C-G>u<C-U>

if has('mouse')
  set mouse=a
endif

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  filetype plugin indent on

  augroup vimrcEx
    au!

    autocmd FileType text setlocal textwidth=78

    autocmd BufReadPost *
          \ if line("'\"") >= 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  set langnoremap
endif

" ==== ==== ==== Vim-Plug ==== ==== ====
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'Shougo/unite.vim'
Plug 'mattn/emmet-vim'
call plug#end()

" ---- ---- molokai scheme ---- ----
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" ---- ---- lightline.vim ---- ----
let g:lightline = {
      \ 'colorscheme': 'jellybeans'
      \}
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
" ---- ---- indent-guides ---- ----
set tabstop=2 shiftwidth=2 expandtab
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=lightgrey ctermbg=lightgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=darkgrey
