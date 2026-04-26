return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"gdscript",
				"godot_resource",
				"gdshader",
				"c_sharp",
			},
			highlight = { enable = true },
			indent = { enable = false },
		})
	end,
}
