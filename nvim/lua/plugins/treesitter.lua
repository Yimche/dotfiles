return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    init = function()
        local ensureInstalled = {
            "astro",
            "bash",
            "c",
            "fish",
            "haskell",
            "html",
            "javascript",
            "json",
            "latex",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "regex",
            "rust",
            "tsx",
            "typescript",
            "vim",
            "yaml",
        }
        local alreadyInstalled = require('nvim-treesitter.config').get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
                end)
         :totable()
          require('nvim-treesitter').install(parsersToInstall)
        vim.api.nvim_create_autocmd('FileType', {
        callback = function()
            -- Enable treesitter highlighting and disable regex syntax
            pcall(vim.treesitter.start)
            -- Enable treesitter-based indentation
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        })
    end,
}
