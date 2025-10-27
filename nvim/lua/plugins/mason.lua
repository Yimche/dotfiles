return {
   "mason-org/mason-lspconfig.nvim",
   opts = {
	ensure_installed = {
            "clangd",
            -- "hls",
	    "jdtls",
	    "lua_ls",
	    "tinymist",
            "pylsp",
            "astro"
	},
        automatic_installation = true,
    },
    dependencies = {
    	{ "mason-org/mason.nvim", opts = {} },
    	"neovim/nvim-lspconfig",
    },
}
