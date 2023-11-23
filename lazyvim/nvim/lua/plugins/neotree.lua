return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    opts = {
      filesystem = {
        filtered_items = {
          visible = false, -- when true, they will just be displayed differently than normal items
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
            ".next",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
        },
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          ["<esc>"] = "open",
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "-",
          expander_expanded = "+",
          expander_highlight = "NeoTreeExpander",
        },
      },
    },
  },
}
