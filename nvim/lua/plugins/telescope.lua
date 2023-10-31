return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      { "<leader><space>", false },
      {
        "<leader>.",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Find Files (Current dir)",
      },
      {
        "<esc>",
        function()
          require("telescope.actions").close()
        end,
        -- mode = { "i", "n" },
        desc = "Close telescope",
      },
    }
  end,
}
