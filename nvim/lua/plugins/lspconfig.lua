local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
    	go({ severity = severity })
    end
end
return {
    "neovim/nvim-lspconfig",
    opts = {
    	--simple = {
    	--	"lua_ls",
    	--	"tinymist",
    	--},
    },
    config = function()
      	local lspconfig = require("lspconfig")
      	lspconfig.clangd.setup({})
      	-- lspconfig.hls.setup({})
      	lspconfig.jdtls.setup({})
      	lspconfig.lua_ls.setup({})
      	lspconfig.tinymist.setup({
      	  	settings = {
      	  	  	formatterMode = "typstfmt",
      	  	  	exportPdf = "onType",
      	  	},
      	  	filetypes = ({ "typst", "typ" }).filetypes,
      	})
        lspconfig.qmlls.setup {}
    end,
    
    keys = {
    	{ "gd", vim.lsp.buf.definition, desc = "Go to definition" },
    	{ "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
    	{ "gI", vim.lsp.buf.implementation, desc = "Go to implementations" },
    	{ "gy", vim.lsp.buf.type_definition, desc = "Go to type definition" },
    	{ "gr", vim.lsp.buf.references, desc = "Go to references" },
    
    	{ "]e", diagnostic_goto(true, "ERROR"), desc = "Go to next error" },
    	{ "[e", diagnostic_goto(false, "ERROR"), desc = "Go to next error" },
    	{ "]w", diagnostic_goto(true, "WARN"), desc = "Go to next warning" },
    	{ "[w", diagnostic_goto(false, "WARN"), desc = "Go to next warning" },
    	-- Java keybinds
    	{
	   "crm",
    	   function()
    	   	require("jdtls").extract_method(true)
    	   end,
    	   mode = "v",
    	   desc = "Extract method (java)",
    	},
    },
}
