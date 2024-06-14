return {
  "folke/trouble.nvim",
  opts = {
    use_diagnostic_signs = true,
    auto_close = true,
    auto_preview = false,
    focus = true,
    win = {
      type = "split",
      size = { width = 0.3, height = 0.4 },
      position = "right",
    },
    preview = {
      type = "float",
      scratch = true,
      border = "rounded",
      relative = "win",
    },
    modes = {
      lsp_references_buffer = {
        mode = "lsp_references",
        filter = { buf = 0 },
        win = {
          type = "split",
          size = { width = 0.3, height = 0.4 },
          position = "right",
        },
      },
    },
  },
  keys = {
    { "<leader>cx", "<cmd>Trouble lsp_references_buffer toggle<cr>", desc = "LSP references (buffer)" },
    { "<leader>cX", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references (project)" },
  },
}
