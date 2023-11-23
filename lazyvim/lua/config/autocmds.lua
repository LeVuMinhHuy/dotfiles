-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_augroup("neotree_autoopen", { clear = true })
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     desc = "Open neo-tree on enter",
--     group = "neotree_autoopen",
--     callback = function()
--         if not vim.g.neotree_opened then
--             vim.cmd("Neotree position=top buffers")
--             vim.cmd("Neotree")
--             vim.g.neotree_opened = true
--         end
--     end,
-- })

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme kanagawa]])
vim.api.nvim_command("ZenMode")
