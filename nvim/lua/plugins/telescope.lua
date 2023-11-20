local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

return {
  "nvim-telescope/telescope.nvim",
  keys = function()
    return {
      { "<leader><space>", false },
      {
        "<leader>.",
        builtin.find_files,
        desc = "Find Files (Current dir)",
      },
      {
        "<leader>/?",
        builtin.keymaps,
        desc = "Keymaps",
      },
      {
        "<leader>/b",
        builtin.buffers,
        desc = "Buffers (Open)",
      },
      {
        "<leader>/B",
        builtin.oldfiles,
        desc = "Buffers (History)",
      },
      {
        "<leader>/c",
        builtin.commands,
        desc = "Commands",
      },
      {
        "<leader>/C",
        builtin.command_history,
        desc = "Commands (History)",
      },
      {
        "<leader>/m",
        builtin.marks,
        desc = "Marks",
      },
      {
        "<leader>/r",
        builtin.registers,
        desc = "Registers",
      },
      {
        "<leader>/s",
        builtin.live_grep,
        desc = "Grep for string",
      },
      {
        "<leader>/S",
        builtin.grep_string,
        desc = "Grep for string at cursor",
      },
      {
        "<leader>/t",
        builtin.current_buffer_tags,
        desc = "Tags (Buffer)",
      },
      {
        "<leader>/T",
        builtin.tags,
        desc = "Tags (Project)",
      },
    }
  end,
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<C-d>"] = false,
          ["<C-u>"] = false,
          ["<esc>"] = actions.close,
          ["<C-g>"] = actions.close,
          ["<C-i>"] = actions.select_horizontal,
          ["<C-s>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
          ["<C-b"] = actions.preview_scrolling_up,
          ["<C-f"] = actions.preview_scrolling_down,
        },
      },
    },
  },
}
