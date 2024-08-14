local grug = require("grug-far")

return {
  "MagicDuck/grug-far.nvim",
  opts = { open_cmd = "noswapfile vnew" },
  keys = {
    {
      "<leader>sr",
      function()
        grug.grug_far({})
      end,
      mode = { "n" },
      desc = "Search and Replace",
    },
    {
      "<leader>sr",
      function()
        local current_word = vim.fn.expand("<cword>")
        grug.with_visual_selection({})
      end,
      mode = { "v" },
      desc = "Search and Replace (current word)",
    },
  },
}
