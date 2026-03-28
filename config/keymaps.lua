vim.keymap.set('i', 'jk', '<Esc>')


vim.keymap.set("n", "<Esc>", function()
  vim.cmd("nohlsearch")
  return "<Esc>"
end, { expr = true })

vim.keymap.set("n", "<leader>e", ':Neotree toggle<CR>')
