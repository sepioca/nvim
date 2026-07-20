vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	opts = {
		filesystem = {
			hijack_netrw_behavior = "disabled",
			follow_current_file = {
				enabled = true,
			},
		},
	},
	config = function(_, opts)
		require("neo-tree").setup(opts)
		vim.keymap.set("n", "<leader>e", ":Neotree reveal toggle<CR>")
	end,
}
