"========================================================
" INSTALL PLUGINS
"========================================================
filetype off
call plug#begin('~/.vim/plugged')
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'mbbill/undotree'
Plug 'ryanoasis/vim-devicons'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-scripts/git-time-lapse'
Plug 'benmills/vimux'
Plug 'dense-analysis/ale'
Plug 'christoomey/vim-tmux-navigator'
Plug 'brooth/far.vim'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-signify'
Plug 'dbgx/lldb.nvim'
Plug 'iamcco/markdown-preview.vim'
Plug 'junegunn/goyo.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-neco'
Plug 'derekwyatt/vim-scala'
Plug 'justinmk/vim-sneak'
Plug 'huytd/vim-quickrun'
Plug 'dylon/vim-antlr'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'Shougo/denite.nvim'
call plug#end()
"========================================================
" EDITOR CONFIGS
"========================================================
syntax on
filetype on
filetype indent on
filetype plugin on
set hlsearch
set ai
set ruler
set linespace=1
set gfn=DejaVu\ Sans\ Mono\ for\ Powerline:h13
let g:auto_ctags = 1
set breakindent
set nofoldenable
" set tags=./tags;,tags;
set ruler
set expandtab
set autoindent
set clipboard=unnamed
set splitright
set splitbelow
set ttyfast
set lazyredraw
set laststatus=2
set encoding=utf8
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set background=dark
set bs=2 tabstop=2 shiftwidth=2 softtabstop=2
set number
set nosmd

set mouse=a " enable mouse for all mode
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

set autoindent
set smartindent

" Fix iterm display
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let ayucolor="dark"
colorscheme deep-space


"========================================================
" CUSTOM ICON
"========================================================

"Custom icon for coc.nvim statusline
let g:coc_status_error_sign=" "
let g:coc_status_warning_sign=" "


"========================================================
" CONFIG ANRLT
"========================================================
au BufRead,BufNewFile *.g set filetype=antlr3
au BufRead,BufNewFile *.g4 set filetype=antlr4

"========================================================
" CONFIG PYTHON
"========================================================
" let g:python_host_prog = '/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python'
" let g:python3_host_prog = '/usr/local/bin/python3.7'
"========================================================
" CONFIG ALE
"========================================================
" let g:ale_fixers = {
" \ 'ruby': ['rubocop']
" \ }
" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'c': ["clang"],
" \}
" let g:ale_c_clang_options = "-std=c11 -Wall"
" let g:ale_lint_on_text_changed="never"
" let g:ale_echo_cursor = 1
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_set_highlights = 0
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" highlight SignColumn guibg=255
"========================================================
" CONFIG LIGHTLINE
"========================================================
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '✓' : printf(
    \   'Linter %d🚸 %d⛔️',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

let g:lightline = {
      \ 'colorscheme': 'deepspace',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'alestatus'] ]
      \ },
      \ 'component_function': {
      \   'alestatus': 'LinterStatus'
      \ },
      \ }

"========================================================
" LEADER
"========================================================

let mapleader=" "

"========================================================
" CONFIG COC.nvim
"========================================================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> gy <Plug>(coc-type-definition)
nnoremap <silent> gi <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)
nnoremap <leader>rn <Plug>(coc-rename)

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nnoremap <leader>rn <Plug>(coc-rename)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"========================================================
" CONFIG MISC
"========================================================
let g:sneak#label = 1
" Auto pair
let g:AutoPairsMultilineClose = 0
let g:indentLine_enabled = 0
" Tmux navigation
let g:tmux_navigator_no_mappings = 1
" Rpsec config
let g:VimuxUseNearest = 0
let g:test#strategy = 'vimux'
set timeoutlen=1000 ttimeoutlen=0
if has("autocmd")
  autocmd FileType go set tabstop=8 shiftwidth=8 softtabstop=8
  autocmd FileType xml set equalprg=xmllint\ --format\ -
  autocmd BufWritePre * StripWhitespace
  autocmd BufEnter * autocmd! matchparen
endif

let g:move_key_modifier = 'C'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.html.eex,*.html.erb"
let g:jsx_ext_required = 0


"========================================================
" MAPPING FZF
"========================================================
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_preview_source=" --preview='bat {} --theme=zenburn --color=always'"
noremap <silent> <c-p> <ESC>:call fzf#vim#files('.', {'options': g:fzf_preview_source})<CR>
noremap <silent> <leader>/ <ESC>:BLines<CR>
noremap <leader>rg <ESC>:Rg<space>
noremap <c-]> <ESC>:call fzf#vim#tags(expand("<cword>"), {'options': '--exact'})<cr>
let $FZF_DEFAULT_OPTS='--layout=reverse'
"Open FZF in floating window
let g:fzf_layout = { 'window': 'call FzfFloatingWindow()' }
function! FzfFloatingWindow()
  let height = float2nr((&lines - 2) * 0.6) " lightline + status
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction


"========================================================
" MAPPING MOVEMENT
"========================================================

inoremap jk <ESC>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe ":Use k"<CR>
nnoremap <Down> :echoe ":Use j"<CR>
nnoremap <ESC><ESC> :nohlsearch<CR>


" Vim easymotion
nmap <silent> ;; <Plug>(easymotion-overwin-f)
nmap <silent> ;l <Plug>(easymotion-overwin-line)


"========================================================
" MAPPING COMMENT TOGGLE
"========================================================

map mm <Plug>NERDCommenterToggle

"========================================================
" MAPPING SEPERATOR
"========================================================

nnoremap <Leader>w :w<CR>
nnoremap <Leader>l :vsplit<CR>
nnoremap <Leader>k :split<CR>


"========================================================
" MAPPING TABS
"========================================================

nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>tc :tabe<CR>
nnoremap <Leader>tx :tabclose<CR>

"========================================================
" MAPPING NERDTree
"========================================================
noremap <silent> <Leader>n <ESC>:NERDTreeToggle<CR>
noremap <silent> <Leader>f <ESC>:NERDTreeFind<CR>
let NERDTreeMapOpenSplit = 'x'
let NERDTreeMapOpenVSplit = 'v'

"========================================================
" MAPPING RSPEC
"========================================================
noremap <Leader>tt :TestFile<CR>
noremap <Leader>ts :TestNearest<CR>
noremap <Leader>tl :TestLast<CR>
noremap <Leader>ta :TestSuite<CR>
let test#ruby#rspec#executable = 'bundle exec rspec'

"========================================================
" MAPPING EASYALIGN
"========================================================
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

"========================================================
" MAPPING GIT
"========================================================
nnoremap <silent> <leader>gt :call TimeLapse() <cr>
let g:reviewbase = $REVIEW_BASE
nnoremap <silent> <c-d> :execute 'vert Gdiff '.g:reviewbase<cr>
nnoremap <silent> <c-r> :GitChangesFZF<cr>
function! s:open_review_file(line)
  let keys = split(a:line, '\t')
  bufdo bd
  execute 'e '.keys[2]
  execute 'vert Gdiff '.g:reviewbase
endfunction

command! GitChangesFZF call fzf#run({
\   'source':  'git stat | sort -k3',
\   'sink':    function('<sid>open_review_file'),
\   'window': 'call FzfFloatingWindow()',
\   'options': '--extended --nth=3..',
\   'down':    '30%'
\})

"========================================================
" MAPPING MISC
"========================================================
nnoremap <silent> <CR> <ESC>:noh<CR>
nnoremap <silent> <leader>' cs'"
nnoremap <silent> <leader>" cs"'
nnoremap <silent> <leader>u :UndotreeToggle<CR>
nnoremap <silent> <C-h> <ESC>:TmuxNavigateLeft<CR>
nnoremap <silent> <C-l> <ESC>:TmuxNavigateRight<CR>
nnoremap <silent> <C-k> <ESC>:TmuxNavigateUp<CR>
nnoremap <silent> <C-j> <ESC>:TmuxNavigateDown<CR>
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
nnoremap <silent> <leader>path :let @+=@%<CR>
nnoremap <silent> <leader>t :TagbarToggle<CR>
let vim_markdown_preview_hotkey='<C-r>'
let vim_markdown_preview_github=1

"========================================================
" CONFIG SIGNIFY
"========================================================
let g:signify_vcs_list = ['git']
let g:signify_sign_show_count = 0
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '-'
let g:signify_sign_delete_first_line = '-'
let g:signify_sign_change            = '·'
let g:signify_sign_changedelete      = g:signify_sign_change
highlight SignifySignAdd guibg=255
highlight SignifySignDelete guibg=255
highlight SignifySignChange guibg=255
"========================================================
" LLDB CONFIGS
"========================================================
nnoremap <silent> <leader>lld <ESC>:LLmode debug<CR>
nnoremap <silent> <leader>llc <ESC>:LLmode code<CR>
nnoremap <silent> <leader>lll <ESC>:LLsession load<CR>
nnoremap <silent> <leader>lc <ESC>:LL continue<CR>
nnoremap <silent> <leader>ln <ESC>:LL next<CR>
nnoremap <silent> <leader>ls <ESC>:LL step<CR>
nnoremap <silent> <leader>lp :LL print <C-R>=expand('<cword>')<CR>
vnoremap <silent> <leader>lp :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
nnoremap <leader>lb <Plug>LLBreakSwitch
"========================================================
" STARTIFY CONFIGS
"========================================================
let g:startify_change_to_dir = 0
let g:startify_session_persistence = 1
let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_custom_header = [
      \'                                  Code what you love',
      \'                                  Love what you code',
      \]

