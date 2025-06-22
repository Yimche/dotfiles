local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "
-- Lazy
map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy Menu" })

-- Code
---- Code Action
map("n", "<leader>ca", "<cmd> lua vim.lsp.buf.code_action()<CR>", { desc = "Code Actions"})
---- Line Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
---- Mason
map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason Menu" })
