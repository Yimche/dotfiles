local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

map("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "Lazy Menu" })

map("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason Menu" })

map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "<leader>ca", "<cmd> lua vim.lsp.buf.code_action()<CR>", { desc = "Code Actions"})

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", "\"_dP")

map("n", "Q", "<nop>")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("n", "\\", "<cmd>nohlsearch<CR>")
