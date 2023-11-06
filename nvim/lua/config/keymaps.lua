-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap
local util = require("lazyvim.util")
local lazyterm = function()
  util.terminal(nil, { cwd = util.root(), size = { width = 1.0, height = 0.4 } })
end
local opts = { remap = false, silent = true }

map.del("n", "<leader>ft")
map.del("n", "<leader>fT")
map.del("n", "<c-_>")

map.set("n", "<leader>t", lazyterm, { desc = "Terminal" })
map.set("n", "<c-/>", lazyterm, { desc = "Terminal" })

map.set("n", "<leader>x", "<cmd>tabclose<cr>", { desc = "Close Tab", remap = false })
map.set("i", "jk", "<ESC>", { remap = false })
map.set("n", "==", vim.diagnostic.open_float, opts)
map.set("n", "[d", vim.diagnostic.goto_prev, opts)
map.set("n", "]d", vim.diagnostic.goto_next, opts)
map.set("n", "<space>q", vim.diagnostic.setloclist, opts)
map.set("n", "<Tab>", ">>", opts)
map.set("v", "<Tab>", ">", opts)
map.set("n", "<S-Tab>", "<<", opts)
map.set("v", "<S-Tab>", "<", opts)
map.set("n", "v", "<c-v>", opts)
map.set("n", "<c-v>", "v", opts)
