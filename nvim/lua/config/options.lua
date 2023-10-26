-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.rtp:append("~/.local/fzf")
vim.opt.rtp:append("~/.local/venvs/neovim")
vim.g.python3_host_prog = "~/.local/venvs/neovim/bin/python"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 999
