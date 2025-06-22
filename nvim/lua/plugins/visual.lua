return {
    {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	opts = {
	    integrations = {
		noice = true,
	    	which_key = true,
	    	treesitter = true,
	    },
            transparent_background = true, -- disables setting the background color.
	},
	config = function(_, opts)
	    require("catppuccin").setup(opts)
	    vim.cmd.colorscheme("catppuccin")
	end,
    },
    {	
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
	    presets = {
	    	inc_rename = true,
	    	command_palette = false,
	    	lsp_doc_border = true,
	    },
	    -- add any options here
            views = {
                cmdline_popup = {
                  position = {
                    row = 5,
                    col = "50%",
                  },
                  size = {
                    width = 60,
                    height = "auto",
                  },
                },
                popupmenu = {
                  relative = "editor",
                  position = {
                    row = 8,
                    col = "50%",
                  },
                  size = {
                    width = 60,
                    height = 10,
                  },
                  border = {
                    style = "rounded",
                    padding = { 0, 1 },
                  },
                  win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                  },
                },
            },
            routes = {
                {
                    view = "notify",
                    filter = { event = "msg_showmode" },
                },
            }
	},
	dependencies = {
	    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	    "MunifTanjim/nui.nvim",
	}
    },
}
