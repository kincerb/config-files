return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ansiblels = {
          settings = {
            filetypes = { "yaml.ansible" },
          },
        },
      },
      setup = {
        ansiblels = function()
          require("lazyvim.util").lsp.on_attach(function(client, _) end)
        end,
      },
    },
  },
}
