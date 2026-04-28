local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end

return {
    "neovim/nvim-lspconfig",
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
            filetypes = { "lua" },
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
            filetypes = {"qml"},
        }
        vim.lsp.config["pylsp"] = {
            cmd = { "pylsp" },
            filetypes = { "python" }
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
        vim.lsp.config["verible"] = {
            cmd = { "verible-verilog-ls" },
            filetypes = { "verilog" },
            root_markers = {
                "xpr"
            }
        }
        -- Start them
        local lspconfig = require("lspconfig")
        vim.lsp.enable("clangd")
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pylsp")
        vim.lsp.enable("qmlls")
        vim.lsp.enable("tinymist")
        vim.lsp.enable("astro")
        vim.lsp.enable("verible")

        -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
        -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
        -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
        -- Set vim motion for <Space> + c + r to display references to the code under the cursor
        -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
        -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
        -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
        vim.keymap.set("n", "<leader>ch", function()
            vim.lsp.buf.hover({ max_width = 60, max_height = 12 })
        end, { desc = "[C]ode [H]over Documentation" })
        vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })
        vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
        vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
        vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
        vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
    end,

    keys = {
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

