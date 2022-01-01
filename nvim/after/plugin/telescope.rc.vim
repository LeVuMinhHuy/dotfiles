if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-b> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <silent> <C-p> <cmd>Telescope buffers<cr>

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

