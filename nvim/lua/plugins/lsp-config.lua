return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.typst_lsp.setup({
        setting = {
          exportPdf = "onSave",
        },
        filetypes = ({ "typst", "typ" }).filetypes,
      })
    end,
  },
}
