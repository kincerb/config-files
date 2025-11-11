return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    opts = {
      shade_terminals = false,
      open_mapping = [[<c-/>]],
      terminal_mappings = true,
      insert_mappings = true,
      direction = "horizontal",
      persist_size = false,
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
          return math.floor(vim.o.lines * 0.6)
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.5)
        end
      end,
    },
    keys = {
      {
        "<leader>tt",
        "<cmd>ToggleTerm direction=horizontal<cr>",
        mode = { "n" },
        desc = "ToggleTerm (horizontal ---)",
      },
      {
        "<leader>tT",
        "<cmd>ToggleTerm direction=vertical<cr>",
        mode = { "n" },
        desc = "ToggleTerm (vertical |||)",
      },
      {
        "<leader>tf",
        "<cmd>ToggleTerm direction=float<cr>",
        mode = { "n" },
        desc = "ToggleTerm (float)",
      },
      {
        "<leader>t=",
        "<cmd>TermSelect<cr>",
        mode = { "n" },
        desc = "Pick a terminal",
      },
      {
        "<C-.>",
        "<cmd>ToggleTermToggleAll<cr>",
        mode = { "n", "i", "t" },
        desc = "ToggleTerm (all)",
      },
      {
        "<C-/>",
        "<cmd>ToggleTerm<cr>",
        mode = { "n", "i", "t" },
        desc = "ToggleTerm (smart)",
      },
      {
        "<C-_>",
        "<cmd>ToggleTerm<cr>",
        mode = { "n", "i", "t" },
        desc = "ToggleTerm (smart)",
      },
      {
        "<C-e>",
        function()
          local trim_spaces = true
          local buftype = vim.bo.filetype
          if buftype == "python" then
            trim_spaces = false
          end
          require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, {})
          vim.api.nvim_feedkeys("j", "n", false)
        end,
        mode = { "n" },
        desc = "Send current line to terminal",
      },
      {
        "<C-e>",
        function()
          local trim_spaces = true
          local buftype = vim.bo.filetype
          if buftype == "python" then
            trim_spaces = false
          end
          require("toggleterm").send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
          vim.api.nvim_feedkeys("j", "n", false)
        end,
        mode = { "v" },
        desc = "Send selected lines to terminal",
      },
      {
        "<C-E>",
        function()
          local trim_spaces = true
          local buftype = vim.bo.filetype
          if buftype == "python" then
            trim_spaces = false
          end
          require("toggleterm").send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
        end,
        mode = { "v" },
        desc = "Send selected lines to terminal",
      },
    },
  },
}
