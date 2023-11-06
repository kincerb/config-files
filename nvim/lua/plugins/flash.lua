return {
  "folke/flash.nvim",
  keys = function()
    return {
      {
        "s",
        mode = { "n" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    }
  end,
}
