return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        opts = {
            integrations = {
                noice = true,
                which_key = true,
                treesitter = true,
            },
            transparent_background = true, -- disables setting the background color.
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
