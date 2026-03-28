return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = true,
  keys = {
    { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
    { "<leader>m", function() local h = require("harpoon") h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon menu" },
    { "<C-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
    { "<C-j>", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
    { "<C-k>", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
    { "<C-l>", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    { "<leader>n", function() require("harpoon"):list():next({ ui_nav_wrap = true }) end, desc = "Harpoon next" },
    { "<leader>p", function() require("harpoon"):list():prev({ ui_nav_wrap = true }) end, desc = "Harpoon prev" },
  },
  config = function()
    require("harpoon"):setup()
  end,
}
