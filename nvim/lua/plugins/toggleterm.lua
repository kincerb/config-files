return {
  {
    "akinsho/toggleterm.nvim",
    lazy = true,
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-_>]],
      terminal_mappings = true,
      insert_mappings = true,
      direction = "horizontal",
      float_opts = {
        border = "curved",
        width = function(_)
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function(_)
          return math.floor(vim.o.lines * 0.6)
        end,
        winblend = 0,
        zindex = 10,
      },
      size = function(term)
        if term.direction == "horizontal" then
          return math.floor(vim.o.lines * 0.5)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
    },
    keys = {
      {
        "<leader>tt",
        function()
          require("toggleterm").toggle(nil, nil, nil, "horizontal")
        end,
        mode = { "n" },
        desc = "ToggleTerm (horizontal ---)",
      },
      {
        "<leader>tT",
        function()
          require("toggleterm").toggle(nil, nil, nil, "vertical")
        end,
        mode = { "n" },
        desc = "ToggleTerm (vertical |||)",
      },
      {
        "<leader>tf",
        function()
          require("toggleterm").toggle(nil, nil, nil, "float")
        end,
        mode = { "n" },
        desc = "ToggleTerm (float)",
      },
      -- {
      --   "<C-/>",
      --   function()
      --     require("toggleterm").smart_toggle(nil, nil, nil, nil)
      --   end,
      --   mode = { "n" },
      --   desc = "ToggleTerm (smart)",
      -- },
      -- {
      --   "<C-_>",
      --   function()
      --     require("toggleterm").smart_toggle(nil, nil, nil, nil)
      --   end,
      --   mode = { "n" },
      --   desc = "ToggleTerm (smart)",
      -- },
    },
  },
}
