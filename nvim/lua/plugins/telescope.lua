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
        "<leader>/.",
        builtin.resume,
        desc = "Resume previous",
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
        "<leader>/e",
        builtin.colorscheme,
        desc = "Colorscheme",
      },
      {
        "<leader>/E",
        builtin.highlights,
        desc = "Highlights",
      },
      {
        "<leader>/m",
        builtin.marks,
        desc = "Marks",
      },
      {
        "<leader>/p",
        builtin.pickers,
        desc = "Pickers",
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
    pickers = {
      buffers = {
        mappings = {
          i = {
            ["<C-x>"] = actions.delete_buffer + actions.move_to_top,
          },
        },
      },
    },
    defaults = {
      mappings = {
        i = {
          ["<C-d>"] = false,
          ["<C-u>"] = false,
          ["<C-x>"] = false,
          ["<esc>"] = actions.close,
          ["<C-b"] = actions.preview_scrolling_up,
          ["<C-e>"] = actions.edit_command_line,
          ["<C-f"] = actions.preview_scrolling_down,
          ["<C-g>"] = actions.close,
          ["<C-i>"] = actions.select_horizontal,
          ["<C-v>"] = actions.select_vertical,
          ["<C-t>"] = actions.select_tab,
        },
      },
    },
  },
}
