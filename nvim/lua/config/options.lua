-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.python3_host_prog = "~/.local/venvs/neovim/bin/python"
vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_python_ruff = "ruff"
vim.g.lazyvim_picker = "fzf"
vim.g.root_spec = { { ".git" }, "lsp", "cwd" }
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamed,unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 0 -- set to 999 to keep content in middle
vim.opt.sidescrolloff = 8
-- disable automatic comment leader ofter hitting 'o' or 'O' see :help fo-table
vim.opt.formatoptions:remove({ "o" })
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.filetype.add({
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  pattern = {
    [".*compose.yml"] = "yaml.docker-compose",
    [".*compose.yml.j2"] = "jinja",
    [".*nginx.conf.j2"] = "jinja",
    ["*.nginx.conf"] = "nginx",
  },
})
