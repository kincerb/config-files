return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      ruff = {
        cmd_env = { RUFF_TRACE = "messages" },
        init_options = {
          settings = {
            logLevel = "error",
          },
        },
        keys = {
          {
            "<leader>co",
            LazyVim.lsp.action["source.organizeImports"],
            desc = "Organize Imports",
          },
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportUnusedImport = false,
                reportDuplicateImport = false,
              },
            },
          },
        },
      },
    },
    setup = {
      ruff = function()
        LazyVim.lsp.on_attach(function(client, _)
          if client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,
    },
  },
}
