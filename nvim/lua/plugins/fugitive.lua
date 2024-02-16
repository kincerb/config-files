return {
  {
    "tpope/vim-fugitive",
    enabled = true,
    lazy = false,
    keys = function()
      return {
        { "<leader>gd", "<cmd>Gdiffsplit!<cr>", mode = "n", desc = "Open file in diff split" },
        { "<leader>gm", "<cmd>Git mergetool<cr>", mode = "n", desc = "Open file with mergetool" },
        { "<leader>gw", "<cmd>Gwrite!<cr>", mode = "n", desc = "Write file to HEAD" },
      }
    end,
  },
}
