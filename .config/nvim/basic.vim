if &compatible
  set nocompatible
endif

" :W sudo save
command! W w !sudo tee % > /dev/null

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

" search
set hlsearch
set incsearch

" show
set showmatch


set ruler " show corrent position
set number
set cmdheight=2
set laststatus=2
set hid
set noerrorbells
set novisualbell
set ffs=unix,dos,mac

