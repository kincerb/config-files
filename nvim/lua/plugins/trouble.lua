return {
  "folke/trouble.nvim",
  opts = {
    use_diagnostic_signs = true,
    auto_close = true,
    auto_preview = false,
    focus = true,
    win = {
      type = "split",
      size = math.floor(vim.o.columns * 0.4),
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
          size = math.floor(vim.o.columns * 0.4),
          position = "right",
        },
      },
      project_errors = {
        mode = "diagnostics",
        filter = {
          any = {
            buf = 0,
            {
              severity = vim.diagnostic.severity.ERROR,
              function(item)
                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
              end,
            },
          },
        },
      },
      diagnostics = {
        win = {
          type = "split",
          size = math.floor(vim.o.lines * 0.3),
          position = "bottom",
        },
      },
    },
  },
  keys = {
    { "<leader>cx", "<cmd>Trouble lsp_references_buffer toggle<cr>", desc = "LSP references (buffer)" },
    { "<leader>cX", "<cmd>Trouble lsp_references toggle<cr>", desc = "LSP references (project)" },
    { "<leader>c.", "<cmd>Trouble project_errors toggle<cr>", desc = "Diagnostics (project)" },
  },
}
