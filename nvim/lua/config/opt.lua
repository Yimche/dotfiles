-- Setting Status Column (Line Numbers)
vim.opt.nu = true
vim.opt.rnu = true

-- Tabs and indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Disable wrap
vim.opt.wrap = false

-- Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.title = true
vim.opt.titlestring = "%t"

-- Scroll
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

-- Yank
vim.opt.clipboard = "unnamedplus"

vim.opt.colorcolumn = "80,100"

vim.opt.updatetime = 50

-- fold
vim.opt.foldenable      = false
vim.opt.foldcolumn      = "0"
vim.opt.foldmethod      = "manual"
--vim.opt.foldexpr        = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext        = ""
vim.opt.foldlevel       = 99
vim.opt.foldlevelstart  = -1
vim.opt.foldnestmax     = 4

