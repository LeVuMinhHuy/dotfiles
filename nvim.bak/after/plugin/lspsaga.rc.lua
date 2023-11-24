local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.setup({
  code_action_icon = "",
  code_action_lightbulb = {
    enable = false,
    enable_in_insert = false,
    cache_code_action = false,
    sign = false,
    update_time = 150,
    sign_priority = 20,
    virtual_text = false,
  },
  diagnostic_header = { " ", " ", " ", "ﴞ "},
  border_style = "rounded",
})


keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", {silent = true})
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
keymap("n", "J", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
keymap("n", ",,", "<cmd>Lspsaga code_action<CR>", { silent = true })

