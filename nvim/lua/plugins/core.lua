return {
  { "rafi/awesome-vim-colorschemes" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      terminal_colors = true,
      transparent = true,
      styles = {
        sidebars = "dark",
        floats = "dark",
      },
      on_highlights = function(hl, colors)
        hl.FloatBorder = {
          fg = colors.green,
          bg = colors.bg_float,
        }
        hl.Folded = {
          fg = "#1ae707",
          bg = "#1d2131",
        }
        hl.LspFloatWinBorder = {
          fg = "#27a1b9",
        }
        hl.LspInfoBorder = {
          fg = "#27a1b9",
        }
        hl.CursorLine = {}
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
