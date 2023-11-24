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
nnoremap <A-l> <C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k

" Map leader
let mapleader=" "

" Split windows
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>

" Vim easymotion
"nmap <silent> ;; <Plug>(easymotion-overwin-f)
"nmap <silent> ;l <Plug>(easymotion-overwin-line)

" Open tab on NERDTree, <Esc> instead of <Enter>
nmap <Esc> <Enter>

" Floating windows
nnoremap <silent> <A-d> :Lspsaga term_toggle<CR>
tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga term_toggle<CR>

" Sort impprts
nnoremap <C-o> :OrganizeImports<CR>

" Copy and paste
vnoremap <Leader>y "*y
nnoremap <Leader>p "*p

" Move lines
nnoremap <S-A-j> :m .+1<CR>==
nnoremap <S-A-k> :m .-2<CR>==
inoremap <S-A-j> <Esc>:m .+1<CR>==gi
inoremap <S-A-k> <Esc>:m .-2<CR>==gi
vnoremap <S-A-j> :m '>+1<CR>gv=gv
vnoremap <S-A-k> :m '<-2<CR>gv=gv

xnoremap p pgvy

" ChatGPT
nnoremap <C-c> :ChatGPT<CR>

" Resize windows
nnoremap <S-h> :vertical resize +2<CR>
nnoremap <S-l> :vertical resize -2<CR>
