return {
  "mason-org/mason.nvim",
  version = "1.11.0",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    version = "1.32.0",
  },
  opts = {
    ensure_installed = {
      "debugpy",
    },
  },
}
