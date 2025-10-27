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

-- fold
vim.opt.foldenable      = false
vim.opt.foldcolumn      = "0"
vim.opt.foldmethod      = "manual"
--vim.opt.foldexpr        = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext        = ""
vim.opt.foldlevel       = 99
vim.opt.foldlevelstart  = -1
vim.opt.foldnestmax     = 4

vim.lsp.enable('jdtls')
