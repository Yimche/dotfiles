local function get_root()
  local bufname = vim.api.nvim_buf_get_name(0)

  local root = vim.fs.root(bufname, {
    "Makefile",
    "config",
    "init.lua",
    ".conf",
    "config.jsonc",
    ".git",
  })

  return root or vim.loop.cwd()
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        defaults = {
            border = true,
            borderchars = {
                prompt  = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            },
        }
    },
	keys = {
        {
            "<leader><space>", function()
                local builtin = require("telescope.builtin")
                builtin.find_files({
                    cwd = get_root(),
                })
            end
        },
        {
            "<leader>rg", function()
                local builtin = require("telescope.builtin")
                builtin.live_grep({
                    cwd = get_root(),
                })
            end
        },
			-- { "<leader>rg", "<cmd>Telescope live_grep<cr>", desc = "Find Files (Root Dir)"}
	}
}
