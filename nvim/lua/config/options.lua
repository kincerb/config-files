-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.python3_host_prog = "~/.local/venvs/neovim/bin/python"
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamed,unnamedplus"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 0 -- set to 999 for padding at bottom
-- disable automatic comment leader ofter hitting 'o' or 'O' see :help fo-table
vim.opt.formatoptions:remove({ "o" })
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
