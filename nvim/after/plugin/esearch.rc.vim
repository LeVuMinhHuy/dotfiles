" Use <c-f><c-f> to start the prompt, use <c-f>iw to pre-fill with the current word
" or other text-objects. Try <plug>(esearch-exec) to start a search instantly.
nmap <c-f> <plug>(esearch)

let g:esearch = {}

" Use regex matching with the smart case mode by default and avoid matching text-objects.
let g:esearch.regex   = 1
let g:esearch.textobj = 0
let g:esearch.case    = 'smart'

" Set the initial pattern content using the highlighted '/' pattern (if
" v:hlsearch is true), the last searched pattern or the clipboard content.
let g:esearch.prefill = ['hlsearch', 'last', 'clipboard']

" Override the default files and directories to determine your project root. Set it
" to blank to always use the current working directory.
let g:esearch.root_markers = ['.git', 'Makefile', 'node_modules']


" Redefine the default highlights (see :help highlight and :help esearch-appearance)
highlight      esearchHeader     cterm=bold gui=bold ctermfg=white ctermbg=white
highlight link esearchStatistics esearchFilename
highlight link esearchFilename   Label
highlight      esearchMatch      ctermbg=27 ctermfg=15 guibg='#005FFF' guifg='#FFFFFF'

" Try to jump into the opened floating window or open a new one.
let g:esearch.win_new = {esearch ->
  \ esearch#buf#goto_or_open(esearch.name, {name ->
  \   nvim_open_win(bufadd(name), v:true, {
  \     'relative': 'editor',
  \     'row': &lines / 10,
  \     'col': &columns / 10,
  \     'width': &columns * 8 / 10,
  \     'height': &lines * 8 / 10
  \   })
  \ })
  \}
" Close the floating window when opening an entry.
autocmd User esearch_win_config autocmd BufLeave <buffer> quit
