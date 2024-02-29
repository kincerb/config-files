return {
  "stevearc/aerial.nvim",
  opts = {
    layout = {
      max_width = { 40, 0.4 },
      default_direction = "prefer_right",
      placement = "edge",
    },
    on_attach = function(bufnr)
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
  keys = {
    { "<leader>ct", "<cmd>AerialToggle<CR>" },
  },
}
