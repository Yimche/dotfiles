return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        sidebar = "transparent",
        float = "transparent",
      },
    },
  },
  --{ "shaunsingh/nord.nvim" },
  --{ "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
