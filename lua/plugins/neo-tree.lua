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
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>")
  end,
}
