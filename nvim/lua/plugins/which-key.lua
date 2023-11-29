return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    if require("lazyvim.util").has("telescope.nvim") then
      opts.defaults["<leader>/"] = { name = "+telescope" }
    end
    opts.defaults["<leader>\\"] = { name = "+toggleterm" }
  end,
}
