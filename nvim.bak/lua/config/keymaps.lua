-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

local search_by_word = function()
    local conf = require("telescope.config").values
    require("telescope.builtin").live_grep({
        vimgrep_arguments = table.insert(conf.vimgrep_arguments, "--fixed-strings"),
    })
end

local builtin = require("telescope.builtin")
local project_files = function()
    vim.fn.system("git rev-parse --is-inside-work-tree")
    if vim.v.shell_error == 0 then
        builtin.git_files(opts)
    else
        builtin.find_files(opts)
    end
end

-- Exist insert mode with "jk"
keymap("i", "jk", "<Esc>", opts)

-- Delete a word backward,
-- Remember that delete a word normally is "de"
keymap("n", "dw", 'vb"_d')

-- Moving
keymap("n", "<C-k>", "<C-u>", opts)
keymap("n", "<C-j>", "<C-d>", opts)
keymap("n", "l", "w", opts)
keymap("n", "h", "b", opts)
keymap("n", "<C-l>", "l", opts)
keymap("n", "<C-h>", "h", opts)

-- Jumplist
keymap("n", "<C-m>", "<C-i>", opts)

-- Split window
keymap("n", "ss", ":vsplit<Return>", opts)
keymap("n", "sv", ":split<Return>", opts)

-- Move window
keymap("n", "<A-h>", "<C-w>h")
keymap("n", "<A-k>", "<C-w>k")
keymap("n", "<A-j>", "<C-w>j")
keymap("n", "<A-l>", "<C-w>l")

-- Resize window
keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")

-- Telescope find files
keymap("n", "<leader><leader>", "<cmd>lua require('telescope.builtin').git_files()<cr>")

-- Switch to other buffer
-- keymap("n", "<C-p>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<C-p>", "<CMD>Telescope oldfiles<CR>", opts)

-- Neotree
keymap("n", "<C-n>", "<cmd>Neotree<cr>")
keymap("n", "<S-b>", "<cmd>Neotree position=top buffers<cr>")
keymap("n", "<C-b>", function()
    project_files()
end, opts)

-- Code Action
keymap("n", ",,", "<cmd>lua vim.lsp.buf.code_action()<cr>")

-- Goto Diagnostic
keymap("n", "<S-j>", diagnostic_goto(true, "ERROR"))
keymap("n", "<S-h>", diagnostic_goto(true, "WARN"))

-- Zen mode
keymap("n", "<leader>z", function()
    vim.api.nvim_command("ZenMode")
    vim.notify(" stay calm !", "info", { title = "Zen mode" })
end)

-- LSP
keymap("n", "gi", function()
    require("telescope.builtin").lsp_implementations()
end)

-- Telescope find by word
keymap("n", "<leader>sg", search_by_word)
keymap("n", "<C-f>", search_by_word)

-- GitSigns
keymap("n", "<leader>ss", function()
    vim.cmd("Gitsigns toggle_linehl")
    vim.cmd("Gitsigns toggle_deleted")
end)
