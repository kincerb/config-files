return {
  "L3MON4D3/LuaSnip",
  keys = function()
    return {}
  end,
  config = function()
    require("luasnip.loaders.from_snipmate").lazy_load()
  end,
}
