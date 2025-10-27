vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.typ",
  command = "set filetype=typst",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.pxi",
  command = "set filetype=python",
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.hs",
  command = "HlsStart",
})

vim.cmd([[ autocmd FocusLost * nested silent! wa ]])

-- Persistent Folds
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})
