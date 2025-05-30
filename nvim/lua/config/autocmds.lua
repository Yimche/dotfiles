-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.typ",
  command = "set filetype=typst",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.pxi",
  command = "set filetype=python",
})

vim.cmd([[ autocmd FocusLost * nested silent! wa ]])

-- Folds
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local save_fold = augroup("Persistent Folds", { clear = true })
