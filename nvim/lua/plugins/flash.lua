return {
  "folke/flash.nvim",
  keys = function()
    return {
      { "<c-s>", false, mode = { "c" } },
      {
        "s",
        function()
          require("flash").jump()
        end,
        mode = { "n" },
        desc = "Flash",
      },
    }
  end,
}
