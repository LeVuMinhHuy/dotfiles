if !exists('g:loaded_lspsaga') | finish | endif

lua << EOF
local saga = require 'lspsaga'
local map = nvim_buf_set_keymap,

saga.init_lsp_saga {
  error_sign = '◗',
  warn_sign = '▲',
  hint_sign = '◈',
  infor_sign = '〄',
  border_style = "round",
}

EOF

nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> gp :Lspsaga preview_definition<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> K :Lspsaga hover_doc<CR>
nnoremap <silent> J :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> iu :Lspsaga code_action<CR>
vnoremap <silent> iu <C-U>Lspsaga range_code_action<CR>
