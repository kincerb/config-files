local highlight = {
  "Indent1",
  "Indent2",
  "Indent3",
  "Indent4",
  "Indent5",
  "Indent6",
  "Indent7",
  "Indent8",
}
return {
  {
    "snacks.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.api.nvim_set_hl(0, "Indent1", { fg = "#5A6D73", force = true })
      vim.api.nvim_set_hl(0, "Indent2", { fg = "#f2960c", force = true })
      vim.api.nvim_set_hl(0, "Indent3", { fg = "#0E4573", force = true })
      vim.api.nvim_set_hl(0, "Indent4", { fg = "#b7d111", force = true })
      vim.api.nvim_set_hl(0, "Indent5", { fg = "#d11711", force = true })
      vim.api.nvim_set_hl(0, "Indent6", { fg = "#6E6A01", force = true })
      vim.api.nvim_set_hl(0, "Indent7", { fg = "#590273", force = true })
      vim.api.nvim_set_hl(0, "Indent8", { fg = "#066B78", force = true })
      vim.api.nvim_set_hl(0, "IndentScope", { fg = "#05f731", force = true })
    end,
    opts = {
      indent = {
        indent = {
          enabled = true,
          only_scope = false,
          only_current = false,
          hl = highlight,
        },
        animate = {
          enabled = true,
          style = "up_down",
        },
        scope = {
          enabled = true,
          underline = true,
          only_current = false,
          hl = "IndentScope",
        },
      },
    },
  },
}
