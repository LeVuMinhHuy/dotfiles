local status, gitconflict = pcall(require, "git-conflict")
if (not status) then return end

gitconflict.setup()

local keymap = vim.keymap.set
keymap('n', 'co', '<Plug>(git-conflict-ours)')
keymap('n', 'ct', '<Plug>(git-conflict-theirs)')
keymap('n', 'cb', '<Plug>(git-conflict-both)')
keymap('n', 'c0', '<Plug>(git-conflict-none)')
keymap('n', ']x', '<Plug>(git-conflict-prev-conflict)')
keymap('n', '[x', '<Plug>(git-conflict-next-conflict)')
keymap("n", "cl", "<cmd>GitConflictListQf<CR>", { silent = true })
