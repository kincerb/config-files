return {
  {
    "tpope/vim-fugitive",
    dependencies = {
      "tpope/vim-rhubarb",
    },
    enabled = true,
    lazy = false,
    keys = function()
      return {
        { "<leader>gd", "<cmd>Gdiffsplit!<cr>", mode = "n", desc = "Open file in diff split" },
        { "<leader>gm", "<cmd>Git mergetool<cr>", mode = "n", desc = "Open file with mergetool" },
        { "<leader>gw", "<cmd>Gwrite!<cr>", mode = "n", desc = "Write file to HEAD" },
        { "<leader>gB", "<cmd>GBrowse<cr>", mode = { "n" }, desc = "Git browse" },
        { "<leader>gB", "<cmd>0GBrowse<cr>", mode = { "x" }, desc = "Git browse" },
      }
    end,
  },
}
