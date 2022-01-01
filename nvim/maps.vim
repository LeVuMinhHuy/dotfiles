" Description: Keymaps

" Move window
map <Space> <C-w>w

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


" Map leader
let mapleader="'"

" Split windows
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>
nnoremap <Leader>tn :tabedit 

" Vim easymotion
nmap <silent> ;; <Plug>(easymotion-overwin-f)
nmap <silent> ;l <Plug>(easymotion-overwin-line)

nmap <silent> <Tab> <C-m>
