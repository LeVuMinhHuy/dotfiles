local keymap = vim.keymap.set
keymap('n', '<leader>ff', '<CMD>DiffviewFileHistory<CR>', {noremap = true, silent = true})
keymap('n', '<leader>fo', '<CMD>DiffviewOpen<CR>', {noremap = true, silent = true})
keymap('n', '<leader>ft', '<CMD>DiffviewToggleFiles<CR>', {noremap = true, silent = true})

