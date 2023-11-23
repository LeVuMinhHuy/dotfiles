return {
    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
    },

    -- gruvbox
    { "ellisonleao/gruvbox.nvim", priority = 1000, config = true, opts = {
        transparent_mode = true,
    } },

    -- catppuccin
    {
        "catppuccin/nvim",
        lazy = true,
        name = "catppuccin",
        opts = {
            flavour = "frappe", -- latte, frappe, macchiato, mocha
            transparent_background = false,
        },
    },

    -- everforest
    {
        "sainnhe/everforest",
        lazy = true,
        name = "everforest",
        opts = {
            everforest_background = "hard",
        },
    },

    -- gruvbox material
    {
        "sainnhe/gruvbox-material",
        lazy = true,
        name = "gruvbox-material",
        opts = {
            gruvbox_material_background = "soft",
        },
    },

    -- Configure LazyVim to load colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            --colorscheme = "catppuccin",
            --colorscheme = "everforest",
            --colorscheme = "gruvbox-material",
            --colorscheme = "gruvbox",
            colorscheme = "kanagawa",
        },
    },
}
