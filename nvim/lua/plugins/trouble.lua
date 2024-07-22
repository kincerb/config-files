return {
  "folke/trouble.nvim",
  opts = {
    use_diagnostic_signs = true,
    auto_close = true,
    auto_preview = false,
    focus = true,
    win = {
      type = "split",
      size = function()
        return math.floor(vim.o.columns * 0.4)
      end,
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
          size = function()
            return math.floor(vim.o.columns * 0.4)
          end,
          position = "right",
        },
      },
      diagnostics = {
        win = {
          type = "split",
          size = function()
            return math.floor(vim.o.lines * 0.3)
          end,
          position = "bottom",
        },
      },
    },
  },
  keys = {
    { "<leader>cx", "<cmd>Trouble lsp_references_buffer toggle<cr>", desc = "LSP references (buffer)" },
    { "<leader>cX", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references (project)" },
  },
}
