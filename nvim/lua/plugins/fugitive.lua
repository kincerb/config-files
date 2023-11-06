return {
  {
    "tpope/vim-fugitive",
    enabled = true,
    lazy = false,
    keys = {
      { "<leader>ga", "<cmd>Git add %<cr>", mode = "n", desc = "Add file to git" },
    },
  },
}
