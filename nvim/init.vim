autocmd!

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
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Fish
au BufNewFile,BufRead *.fish set filetype=fish

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.py,.md
