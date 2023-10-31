return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                autopep8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                yapf = { enabled = false },
                pydocstyle = { enabled = false, convention = "google" },
              },
            },
          },
        },
        ruff_lsp = {
          keys = {},
          settings = {
            filetypes = { "python" },
            init_options = {
              settings = {
                organizeImports = true,
                fixAll = true,
                codeAction = {
                  disableRuleComment = { enable = true },
                },
              },
            },
          },
        },
      },
      setup = {
        ruff_lsp = function()
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "ruff_lsp" then
              client.server_capabilities.hoverProvider = false
              client.server_capabilities.completion = false
              client.server_capabilities.definition = false
              client.server_capabilities.references = false
              client.server_capabilities.rename = false
              client.server_capabilities.signatureHelp = false
            end
          end)
        end,
      },
    },
  },
}
