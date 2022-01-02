" Config how NERDTree open and close
autocmd!
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Setup something
set number
set encoding=UTF-8
set autoindent
set lazyredraw
set ignorecase
set smarttab
set ai
set si
set backspace=start,eol,indent
set hidden
set nobackup
set nowritebackup
set relativenumber
set tabstop=2
set shiftwidth=2


" Setup mapping key
runtime ./maps.vim

" Setup plugin imports
runtime ./plug.vim


" Setup color
syntax enable
set termguicolors
runtime ./colors/OneMonokai.vim
colorscheme one_monokai


" File types
au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.fish set filetype=fish
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.py,.md

" Setup functions 
runtime ./functions.vim


