return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "==", vim.lsp.buf.code_action, mode = "n", desc = "Code Actions" },
      { "K", vim.lsp.buf.hover, mode = "n", desc = "Hover" },
    },
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = false,
      },
      servers = {
        ansiblels = {
          settings = {
            filetypes = { "yaml.ansible" },
          },
        },
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},
        gopls = {},
        html = {},
        jsonls = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                autopep8 = { enabled = false },
                mccabe = { enabled = false },
                pycodestyle = { enabled = false },
                yapf = { enabled = false },
                mypy = { enabled = true },
                pydocstyle = { enabled = false, convention = "google" },
                rope_autoimport = {
                  enabled = true,
                  code_actions = { enabled = true },
                },
              },
            },
          },
        },
        ruff_lsp = {
          on_attach = function(client)
            client.server_capabilities.hoverProvider = false
          end,
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
        taplo = {},
        yamlls = {},
      },
    },
  },
}
