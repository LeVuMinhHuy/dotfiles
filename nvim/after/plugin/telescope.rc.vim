if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-b> <CMD>lua require('telescope.builtin').find_files()<CR>
nnoremap <silent> <C-p> <CMD>Telescope oldfiles<CR>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}
EOF

