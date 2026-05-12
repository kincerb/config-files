return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = {
          enabled = false,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          -- throttle = 1000 / 10,
          view = "mini",
        },
      },
    },
  },
}
