return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
}
