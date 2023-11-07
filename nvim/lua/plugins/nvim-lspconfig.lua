local map = vim.keymap

return {
  {
    "neovim/nvim-lspconfig",
    keys = {
      { "==", vim.lsp.buf.code_action, mode = "n", desc = "Code Actions" },
      { "K", vim.lsp.buf.hover, mode = "n", desc = "Hover" },
    },
    opts = {
      servers = {
        ansiblels = {
          settings = {
            filetypes = { "yaml.ansible" },
          },
        },
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
        ["*"] = function()
          require("lazyvim.util").lsp.on_attach(function(client, bufnr)
            vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr")
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            if client.name == "ruff_lsp" then
              client.server_capabilities.hoverProvider = false
            end
          end)
        end,
      },
    },
  },
}
