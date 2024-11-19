-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap
local opts = { noremap = true, silent = true }
local diag_or_down = function()
  return function()
    if vim.diagnostic.is_enabled({ ns_id = nil, bufnr = 0 }) then
      if #vim.diagnostic.count(0) ~= 0 then
        vim.diagnostic.goto_next()
        vim.api.nvim_feedkeys("zt", "n", false)
      else
        vim.api.nvim_feedkeys("j", "n", false)
      end
    else
      vim.api.nvim_feedkeys("j", "n", false)
    end
  end
end

map.del("n", "<leader>ft")
map.del("n", "<leader>fT")
map.del("n", "<leader>gB")

map.set("i", "<c-CR>", function()
  local _keys = vim.api.nvim_replace_termcodes("<ESC>j", true, false, true)
  vim.api.nvim_feedkeys(_keys, "n", false)
end, opts)
map.set("n", "<CR>", diag_or_down(), opts)
map.set("i", "jk", "<ESC>", { noremap = true })
map.set("n", "==", vim.lsp.buf.code_action, { desc = "Code Actions" })
map.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map.set("n", "<space>q", vim.diagnostic.setloclist, opts)
map.set("n", "<Tab>", ">>", opts)
map.set("v", "<Tab>", ">", opts)
map.set("n", "<S-Tab>", "<<", opts)
map.set("v", "<S-Tab>", "<", opts)
map.set("n", "v", "<c-v>", opts)
map.set("n", "<c-v>", "v", opts)
map.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
