local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.init_lsp_saga()

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "gs", "<cmd>Lspsaga signature_help<CR>", { silent = true })
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "J", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", ",,", "<cmd>Lspsaga code_action<CR>", { silent = true })
