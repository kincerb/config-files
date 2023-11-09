local actions = require("telescope.actions")

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
    }
  end,
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-g>"] = actions.close,
          ["<C-i>"] = actions.select_horizontal,
          ["<C-s>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_drop,
          ["<C-u>"] = false,
        },
      },
    },
  },
}
