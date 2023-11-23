return {
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        keys = {
            { "<Tab>", "<Cmd>BufferLineMoveNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineMovePrev<CR>", desc = "Prev tab" },
            { "<leader><Tab>", "<Cmd>BufferLinePick<CR>", desc = "Pick tab" },
            { "<C-q>", "<Cmd>bdelete<CR>", desc = "Close tab" },
        },
        opts = {
            options = {
                mode = "tabs", -- buffers | tabs
                themable = true,
                numbers = "ordinal",
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = true,
                show_duplicate_prefix = true,
                diagnostics = "nvim_lsp",
                indicator = {
                    icon = "▎", -- this should be omitted if indicator style is not 'icon'
                    style = "icon",
                },
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "right",
                        separator = true,
                    },
                },

                separator_style = "slope",
            },
        },
    },
}
