return {
   "mason-org/mason-lspconfig.nvim",
   opts = {
	ensure_installed = {
            "clangd",
            -- "hls",
	    "jdtls",
	    "lua_ls",
	    "tinymist",
	},
    },
    dependencies = {
    	{ "mason-org/mason.nvim", opts = {} },
    	"neovim/nvim-lspconfig",
    },
}
