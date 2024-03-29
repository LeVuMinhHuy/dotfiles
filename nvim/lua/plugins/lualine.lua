local git_blame = require("gitblame")
vim.g.gitblame_display_virtual_text = 0

return {
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        event = "VeryLazy",
        opts = {
            options = {
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
            },
            winbar = {
                lualine_a = {
                    { "branch", right_padding = 4 },
                    { "diagnostics" },
                },
                -- lualine_b = { "diagnostics" },
                --lualine_b = {
                --    "%=",
                --    {
                --        git_blame.get_current_blame_text,
                --        cond = git_blame.is_blame_text_available,
                --    },
                --},
                lualine_b = {},
                lualine_c = { "%=%t | %m", { "filename", file_status = true, path = 1 } },
                -- lualine_c = {},
                lualine_x = {},
                lualine_y = {},

                --lualine_y = { "filetype", "progress" },

                lualine_z = {
                    { "location", left_padding = 2 },
                },
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                --lualine_z = { { "filename", file_status = true, path = 1 } },
                lualine_c = {
                    "%=",
                    {
                        git_blame.get_current_blame_text,
                        cond = git_blame.is_blame_text_available,
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
