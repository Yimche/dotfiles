local function path()
    local pathstr = vim.fn.expand('%')
    return pathstr
end

return {
    'nvim-lualine/lualine.nvim',
    config = function()
        require('lualine').setup {
          options = {
            icons_enabled = true,
            theme = 'catppuccin',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = false,
            refresh = {
              statusline = 100,
              tabline = 100,
              winbar = 100,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff'},
            lualine_c = {path},
            -- lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_x = {{'filetype', colored = true, icon_only = false, icon = { align = 'left' }},},
            -- lualine_y = {'progress'},
            lualine_y = {'diagnostics','lsp_status',},
            -- lualine_y = {},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end,
    dependencies = {
        { 'nvim-tree/nvim-web-devicons', opt = true },
    },
}
