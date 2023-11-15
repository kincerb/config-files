return {
  { "rafi/awesome-vim-colorschemes" },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
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
