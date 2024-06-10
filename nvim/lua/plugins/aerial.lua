return {
  "stevearc/aerial.nvim",
  opts = {
    layout = {
      max_width = 0.3,
      width = 0.2,
      min_width = 20,
      default_direction = "prefer_right",
      placement = "edge",
      resize_to_content = true,
    },
    close_automatic_events = { "unfocus", "unsupported" },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
  keys = {
    { "<leader>ct", "<cmd>AerialToggle<CR>" },
  },
}
