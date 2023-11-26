return {
    -- kanagawa
    {
        "rebelot/kanagawa.nvim",
        opts = {
            transparent = false,
            background = { -- map the value of 'background' option to a theme
                dark = "wave", -- try "dragon" !
                light = "lotus",
            },
        },
    },

    -- gruvbox
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = {
            transparent_mode = false,
            gruvbox_background = "hard",
        },
    },

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
            gruvbox_material_background = "hard",
        },
    },

    -- Configure LazyVim to load colorscheme
    {
        "LazyVim/LazyVim",
        opts = {
            --colorscheme = "catppuccin",
            --colorscheme = "everforest",
            colorscheme = "gruvbox-material",
            --colorscheme = "gruvbox",
            --colorscheme = "kanagawa",
        },
    },
}
