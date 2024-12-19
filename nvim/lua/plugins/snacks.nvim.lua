local highlight = {
  "SnacksIndent1",
  "SnacksIndent2",
  "SnacksIndent3",
  "SnacksIndent4",
  "SnacksIndent5",
  "SnacksIndent6",
  "SnacksIndent7",
  "SnacksIndent8",
}
return {
  {
    "folke/snacks.nvim",
    lazy = false,
    init = function()
      vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#5A6D73" })
      vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#80121B" })
      vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#0E4573" })
      vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#039c0b" })
      vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#6E6A01" })
      vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#874201" })
      vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#590273" })
      vim.api.nvim_set_hl(0, "SnacksIndent8", { fg = "#066B78" })
      vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#039c0b" })
    end,
    opts = {
      indent = {
        enabled = true,
        only_scope = false,
        only_current = false,
        hl = highlight,
      },
      scope = {
        enabled = true,
        underline = true,
        only_current = false,
        hl = "SnacksIndentScope",
      },
    },
  },
}
