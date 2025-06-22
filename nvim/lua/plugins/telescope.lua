return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	keys = {
			{ "<leader><space>", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
			{ "<leader>rg", "<cmd>Telescope live_grep<cr>", desc = "Find Files (Root Dir)"}
	}
}
