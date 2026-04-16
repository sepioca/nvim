return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = { "lua", "javascript", "typescript", "gdscript", "godot_resource", "gdshader" },
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
