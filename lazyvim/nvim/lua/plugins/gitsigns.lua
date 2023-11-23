return {
    {
        "lewis6991/gitsigns.nvim",
        event = "LazyFile",
        opts = {

            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
            linehl = true, -- Toggle with `:Gitsigns toggle_linehl`
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_formatter = "    :: <author>, <author_time:%Y-%m-%d> ::    ",
        },
    },
    {
        "f-person/git-blame.nvim",
    },
}
