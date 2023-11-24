return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "css",
                "fish",
                "gitignore",
                "go",
                "http",
                "rust",
                "scss",
                "sql",
            },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)

            -- MDX
            vim.filetype.add({
                extension = {
                    mdx = "mdx",
                },
            })
            vim.treesitter.language.register("markdown", "mdx")
        end,
    },
}
