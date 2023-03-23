function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

local telescope = require('telescope')
local actions = require('telescope.actions')
local utils = require('telescope.utils')
local builtin = require('telescope.builtin')
local project_files = function()
  local opts = {} -- define here if you want to define something
  vim.fn.system('git rev-parse --is-inside-work-tree')
  if vim.v.shell_error == 0 then
    builtin.git_files(opts)
  else
    builtin.find_files(opts)
  end
end


-- telescope.load_extension('harpoon')

telescope.setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}

local keymap = vim.keymap.set
keymap('n', '<C-b>', function() project_files() end, {noremap = true, silent = true})
keymap('n', '<C-g>', '<CMD>Telescope git_status<CR>', {noremap = true, silent = true})
keymap('n', '<C-p>', '<CMD>Telescope oldfiles<CR>', {noremap = true, silent = true})
