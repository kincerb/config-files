return {
  "neovim/nvim-lspconfig",
  dependencies = { "saghen/blink.cmp" },
  opts = {
    inlay_hints = { enabled = true },
    codelens = { enabled = false },
    servers = {
      autotools_ls = { settings = {} },
      basedpyright = {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = "basic",
              diagnosticSeverityOverrides = {
                reportUnusedImport = false,
                reportUnusedVariable = false,
                reportDuplicateImport = false,
              },
            },
          },
        },
      },
      docker_compose_language_service = {
        settings = {
          docker_compose_language_service = {
            filetypes = { "yaml.docker-compose" },
            root_markers = { ".git" },
          },
        },
      },
      jinja_lsp = { settings = { filetypes = { "jinja" } } },
      nginx_language_server = {
        settings = {
          nginx_language_server = {
            filetypes = { "nginx" },
          },
        },
      },
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
      yamlls = {
        settings = {
          filetypes = { "yaml", "yaml.gitlab", "yaml.docker-compose" },
        },
      },
    },
    setup = {},
  },
}
