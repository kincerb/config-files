local hooks = require("ibl.hooks")
local highlight = {
  "RainbowGrey",
  "RainbowBlue",
  "RainbowYellow",
  "RainbowGreen",
  "RainbowOrange",
  "RainbowViolet",
  "RainbowCyan",
}
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    init = function()
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowGrey", { fg = "#5A6D73" })
        vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#0E4573" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#6E6A01" })
        vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#367D04" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#874201" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#590273" })
        vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#066B78" })
        vim.api.nvim_set_hl(0, "ScopeBold", { bg = "NONE", fg = "#80121B", bold = false })
      end)
    end,
    opts = {
      indent = { highlight = highlight },
      scope = {
        enabled = true,
        show_start = true,
        show_end = true,
        highlight = { "ScopeBold" },
      },
    },
  },
}
