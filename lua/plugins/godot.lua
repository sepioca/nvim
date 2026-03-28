return {
	{
		"habamax/vim-godot",
		event = "VimEnter",
	},
	{
		"neovim/nvim-lspconfig",
		opts = function()
			-- Start Godot server if project.godot exists
			local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
			if gdproject then
				io.close(gdproject)
				vim.fn.serverstart("./godothost")
			end

			-- Configure gdscript LSP
			vim.lsp.config("gdscript", {
				filetypes = { "gd", "gdscript", "gdscript3" },
			})
			vim.lsp.enable("gdscript")
		end,
	},
}
