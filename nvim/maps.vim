" Description: Keymaps

" Setup Escape
inoremap jk <Esc>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <C-l> l
nnoremap <C-h> h
nnoremap l w
nnoremap h b
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

" Move windows
nmap <Space> <C-w>w

" Map leader
let mapleader="'"

" Split windows
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>

" Vim easymotion
nmap <silent> ;; <Plug>(easymotion-overwin-f)
nmap <silent> ;l <Plug>(easymotion-overwin-line)

" Open tab on NERDTree, <Tab> instead of <Enter>
nmap 1 <C-m>

" Floating windows
nnoremap <silent> <A-d> :Lspsaga open_floaterm<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

" Sort impprts
nnoremap <C-o> :OrganizeImports<CR>

" Manage tabs
nnoremap <C-q> :close<CR>
nnoremap <silent> <Tab> :tabn<CR>

" Manage functions
nnoremap <silent> <A-f> :Vista nvim_lsp<CR>
"nnoremap <silent> <A-f> <C-\><C-n> :Vista nvim_lsp<CR>
