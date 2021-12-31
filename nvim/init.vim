" Set script encoding
scriptencoding utf-8


set number
set encoding=utf-8
set shell=fish
set lazyredraw
set ignorecase
set smarttab
set ai
set si
set nowrap
set backspace=start,eol,indent


" Set color
syntax enable
set termguicolors
runtime ./colors/one_monokai.vim
colorscheme one_monokai



" Using map keys
runtime ./maps.vim
