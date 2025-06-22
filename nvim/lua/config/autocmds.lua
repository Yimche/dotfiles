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
