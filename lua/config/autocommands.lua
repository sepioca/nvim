local autocommand = vim.api.nvim_create_autocmd

autocommand("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.cmd("bd")
			require("telescope.builtin").find_files({ cwd = arg })
		end
	end,
})

autocommand("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
