local autocommand = vim.api.nvim_create_autocmd

autocommand("VimEnter", {
	callback = function()
		local arg = vim.fn.argv(0)
		-- If opened with a directory, close buffer and show alpha
		if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
			vim.schedule(function()
				vim.cmd("bd")
				require("alpha").start()
			end)
		end
	end,
})

autocommand("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
