local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

return {
    "neovim/nvim-lspconfig",
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {},
    config = function()
        -- Define configs for each server
        vim.lsp.config["clangd"] = {
            cmd = { "clangd" },
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "hpp", "h"},
            root_markers = {
                -- ".clangd",
                -- ".clang-tidy",
                -- ".clang-format",
                "compile_commands.json"
                -- "compile_flags.txt",
                -- "configure.ac"
            }
        }
        vim.lsp.config["lua_ls"] = {
            cmd = { "lua-language-server" },
        }
        vim.lsp.config["tinymist"] = {
            cmd = { "tinymist" },
            filetypes = { "typst", "typ" },
            settings = {
                formatterMode = "typstfmt",
                exportPdf = "onType",
            },
        }
        vim.lsp.config["qmlls"] = {
            cmd = { "qmlls" },
        }
        vim.lsp.config["pylsp"] = {
            cmd = { "pylsp" }
        }
        vim.lsp.config["astro"] = {
            cmd = { "astro-ls", "--stdio" },
            filetypes = { "astro" },
            init_options = {
                typescript = {
                },
            },
            root_markers = {
                "jsconfig.json",
                "package.json",
                "tsconfig.json",
            },
        }
        -- Start them
        -- vim.lsp.start(vim.lsp.config["astro"])
        vim.lsp.start(vim.lsp.config["clangd"])
        vim.lsp.start(vim.lsp.config["lua_ls"])
        vim.lsp.start(vim.lsp.config["pylsp"])
        vim.lsp.start(vim.lsp.config["qmlls"])
        vim.lsp.start(vim.lsp.config["tinymist"])
    end,

    keys = {
        { "gd", vim.lsp.buf.definition, desc = "Go to definition" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
        { "gI", vim.lsp.buf.implementation, desc = "Go to implementations" },
        { "gy", vim.lsp.buf.type_definition, desc = "Go to type definition" },
        { "gr", vim.lsp.buf.references, desc = "Go to references" },

        { "]e", diagnostic_goto(true, "ERROR"), desc = "Go to next error" },
        { "[e", diagnostic_goto(false, "ERROR"), desc = "Go to prev error" },
        { "]w", diagnostic_goto(true, "WARN"), desc = "Go to next warning" },
        { "[w", diagnostic_goto(false, "WARN"), desc = "Go to prev warning" },

        -- Java keybinds
        {
            "crm",
            function()
                require("jdtls").extract_method(true)
            end,
            mode = "v",
            desc = "Extract method (java)",
        },
    },
}

