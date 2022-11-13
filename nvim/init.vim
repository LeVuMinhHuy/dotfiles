" Config how NERDTree open and close
autocmd!
" Start NERDTree and put the cursor back in the other window.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
autocmd BufWritePre *.go lua vim.lsp.buf.formatting()
autocmd BufWritePre *.go lua goimports(1000)
let NERDTreeShowHidden=1
let g:NERDTreeMinimalMenu=1

" Setup something
"
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
set expandtab
set clipboard=unnamedplus

" Setup mapping key
runtime ./maps.vim

" Setup plugin imports
runtime ./plug.vim


" Setup color
syntax enable
set termguicolors
runtime ./colors/gruvbox.vim
colorscheme gruvbox 
hi! Normal guibg=NONE ctermbg=NONE

" File types
au BufNewFile,BufRead *.es6 setf javascript
au BufNewFile,BufRead *.tsx setf typescriptreact
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.fish set filetype=fish
set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.py,.md
let g:syntastic_typescript_checks=['tsc', 'tslint']

" typescript: find tsconfig.json
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" rustfmt
let g:rustfmt_autosave = 1

set mouse+=a
