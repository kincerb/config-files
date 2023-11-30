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
        "<cmd>:ToggleTerm direction=horizontal<cr>",
        mode = { "n" },
        desc = "ToggleTerm (horizontal ---)",
      },
      {
        "<leader>tT",
        "<cmd>:ToggleTerm direction=vertical<cr>",
        mode = { "n" },
        desc = "ToggleTerm (vertical |||)",
      },
      {
        "<leader>tf",
        "<cmd>:ToggleTerm direction=float<cr>",
        mode = { "n" },
        desc = "ToggleTerm (float)",
      },
      {
        "<C-/>",
        "<cmd>:ToggleTerm<cr>",
        mode = { "n" },
        desc = "ToggleTerm (smart)",
      },
      {
        "<C-_>",
        "<cmd>:ToggleTerm<cr>",
        mode = { "n" },
        desc = "ToggleTerm (smart)",
      },
      {
        "<leader><C-e>",
        "<cmd>:ToggleTermSendCurrentLine<cr>",
        mode = { "n" },
        desc = "Send current line to terminal",
      },
      {
        "<leader><C-e>",
        "<cmd>:ToggleTermSendVisualLines<cr>",
        mode = { "v" },
        desc = "Send selected lines to terminal",
      },
      {
        "<leader><C-E>",
        "<cmd>:ToggleTermSendVisualSelection<cr>",
        mode = { "v" },
        desc = "Send selection to terminal",
      },
    },
  },
}
