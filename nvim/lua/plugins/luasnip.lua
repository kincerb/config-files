return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {
      {
        "<c-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      {
        "<c-j>",
        function()
          require("luasnip").jump(1)
        end,
        mode = "s",
      },
      {
        "<c-k>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
      },
    }
  end,
  config = function()
    require("luasnip.loaders.from_snipmate").load()
  end,
}
