local keymap = vim.keymap.set
keymap('n', '<leader>dd', function() require("duck").hatch("🐤") end, {})
keymap('n', '<leader>dk', function() require("duck").cook() end, {})

