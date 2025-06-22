-- Setting Status Column (Line Numbers)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

-- Highlight the 80th and 100th columns
vim.opt.colorcolumn = "80,100"

-- Disable wrap
vim.opt.wrap = false

-- Tabs and indentation
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true

-- Scroll
vim.opt.scrolloff = 5

-- Undo
vim.opt.undofile = true

-- Yank
vim.opt.clipboard = "unnamedplus"

-- folds
vim.opt.foldenable      = false
vim.opt.foldmethod      = "expr"
vim.opt.foldexpr        = "nvim_treesitter#foldexpr()"
vim.opt.foldtext        = ""
vim.opt.foldlevel       = 99
vim.opt.foldlevelstart  = -1
vim.opt.foldnestmax     = 4
