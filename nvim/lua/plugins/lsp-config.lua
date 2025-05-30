return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.tinymist.setup({
        settings = {
          formatterMode = "typstfmt",
          exportPdf = "onType",
        },
        filetypes = ({ "typst", "typ" }).filetypes,
      })
      lspconfig.clangd.setup({})
      lspconfig.jdtls.setup({})
    end,
  },
}
