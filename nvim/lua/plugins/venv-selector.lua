return {
  "linux-cultist/venv-selector.nvim",
  branch = "regexp",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  ft = "python",
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  opts = {
    settings = {
      search = {
        project_venvs = {
          command = "fd --unrestricted --exclude 'site-packages' --exclude '.mypy_cache' 'python$' ~/Projects",
        },
      },
      options = {
        enable_cached_venvs = true,
        cached_venv_automatic_activation = false,
        notify_user_on_venv_activation = true,
      },
    },
  },
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select VirtualEnv (from cache)" },
  },
}
