return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = false },
        })
        -- local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        -- parser_config.tmojo = {
        --     install_info = {
        --         url = "~/Code/java/tree-sitter-mojo",
        --         files = { "src/parser.c" },
        --         branch = "main",
        --     },
        -- filetype = "tmojo",
        -- }
        -- vim.treesitter.query.set(
        --         "tmojo",
        --         "highlights",
        --         read_file("/home/trickypr/Code/java/tree-sitter-mojo/queries/highlights.scm")
        -- )
        -- vim.treesitter.query.set(
        --     "tmojo",
        --     "locals",
        --     read_file("/home/trickypr/Code/java/tree-sitter-mojo/queries/locals.scm")
        -- )
        -- vim.filetype.add({ extension = { mj = "tmojo" } })
        -- parser_config.javacc = {
        --     install_info = {
        --         url = "~/Code/java/tree-sitter-javacc", -- local path or git repo
        --         files = { "src/parser.c", "src/scanner.c" }, -- note that some parsers also require src/scanner.c or src/scanner.cc
        --         -- optional entries:
        --         branch = "main", -- default branch in case of git repo if different from master
        --     },
        -- }
    end,
}
