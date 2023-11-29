return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    opts = {
      shade_terminals = false,
      open_mapping = [[<C-\]],
      terminal_mappings = true,
      insert_mappings = true,
      direction = "vertical",
      float_opts = {
        border = "curved",
        width = 100,
        height = 60,
        winblend = 0,
        zindex = 10,
      },
      size = function(term)
        if term.direction == "horizontal" then
          return vim.o.lines * 0.5
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
    },
    keys = {
      {
        "<C-\\>",
        function()
          require("toggleterm").toggle(nil, nil, nil, "horizontal")
        end,
        mode = { "n", "i", "t" },
        desc = "ToggleTerm (vert ---)",
      },
    },
  },
}
