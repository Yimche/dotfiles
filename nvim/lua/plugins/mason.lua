return {
    {
        "mason-org/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig"
        },
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
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = {"java-debug-adapter", "java-test"}
            })
        end
    },
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    }
}
