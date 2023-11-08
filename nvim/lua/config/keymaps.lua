-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap
local util = require("lazyvim.util")
local lazyterm = function()
  util.terminal(nil, { cwd = util.root(), size = { width = 1.0, height = 0.6 } })
end
local opts = { noremap = true, silent = true }

map.del("n", "<leader>ft")
map.del("n", "<leader>fT")
map.del("t", "<c-h>")
map.del("t", "<c-j>")
map.del("t", "<c-l>")
map.del("t", "<c-k>")

map.set("n", "<leader>t", lazyterm, { desc = "Terminal (root dir)" })
map.set("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
map.set("t", "<c-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

map.set("n", "<leader>x", "<cmd>tabclose<cr>", { desc = "Close Tab", noremap = true })
map.set("i", "jk", "<ESC>", { noremap = true })
map.set("n", "==", vim.diagnostic.open_float)
map.set("n", "[d", vim.diagnostic.goto_prev, opts)
map.set("n", "]d", vim.diagnostic.goto_next, opts)
map.set("n", "<space>q", vim.diagnostic.setloclist, opts)
map.set("n", "<Tab>", ">>", opts)
map.set("v", "<Tab>", ">", opts)
map.set("n", "<S-Tab>", "<<", opts)
map.set("v", "<S-Tab>", "<", opts)
map.set("n", "v", "<c-v>", opts)
map.set("n", "<c-v>", "v", opts)
