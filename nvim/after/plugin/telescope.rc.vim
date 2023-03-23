if !exists('g:loaded_telescope') | finish | endif

nnoremap <silent> <C-b> <CMD>Telescope git_files<CR>
nnoremap <silent> <C-g> <CMD>Telescope git_status<CR>

lua << EOF
function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.load_extension('harpoon')

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

