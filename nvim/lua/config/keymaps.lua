-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap
local opts = { remap = false, silent = true }

map.set("n", "<leader>j", "<cmd>tabnext<cr>", { desc = "Next Tab", remap = false })
map.set("n", "<leader>k", "<cmd>tabprevious<cr>", { desc = "Previous Tab", remap = false })
map.set("n", "<leader>x", "<cmd>tabclose<cr>", { desc = "Close Tab", remap = false })
map.set("i", "jk", "<ESC>", { remap = false })
map.set("n", "==", vim.diagnostic.open_float, opts)
map.set("n", "[d", vim.diagnostic.goto_prev, opts)
map.set("n", "]d", vim.diagnostic.goto_next, opts)
map.set("n", "<space>q", vim.diagnostic.setloclist, opts)
