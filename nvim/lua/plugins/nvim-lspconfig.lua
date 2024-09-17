return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    keys[#keys + 1] = { "==", vim.lsp.buf.code_action, mode = "n", desc = "Code Actions" }
    keys[#keys + 1] = { "K", vim.lsp.buf.hover, mode = "n", desc = "Hover" }

    opts.inlay_hints = vim.tbl_extend("force", opts.inlay_hints, {
      enabled = true,
    })

    opts.codelens = vim.tbl_extend("force", opts.codelens, { enabled = true })

    opts.servers = vim.tbl_deep_extend("force", opts.servers, {
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              autopep8 = { enabled = false },
              flake8 = { enabled = false },
              pycodestyle = { enabled = false, hangClosing = true },
              pydocstyle = { enabled = false, convention = "google" },
              pyflakes = { enabled = false },
              pylint = { enabled = false },
              mccabe = { enabled = false },
              mypy = { enabled = true },
              rope_autoimport = {
                enabled = false,
                code_actions = { enabled = true },
              },
              yapf = { enabled = false },
            },
          },
        },
      },
      ruff = {
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
        settings = {
          trace = "messages",
          filetypes = { "python" },
          cmd = { "ruff", "server" },
          init_options = {
            settings = {
              logLevel = "info",
              organizeImports = true,
              fixAll = true,
              codeAction = {
                disableRuleComment = { enable = true },
              },
            },
          },
        },
      },
    })
  end,
}
