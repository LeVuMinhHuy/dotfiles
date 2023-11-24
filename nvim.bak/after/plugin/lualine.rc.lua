local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    section_separators = {left = '', right = ''},
    component_separators = {left = '', right = ''},
    disabled_filetypes = {}
  },

  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {
      { 
        'diagnostics', 
            sources = {"nvim_diagnostic"}, 
            symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '}, 
      },
      'filesize',
      --'hostname',
      {
        'filetype' ,
            icon_only = true
      }
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {},
  extensions = {'fugitive'}
}
