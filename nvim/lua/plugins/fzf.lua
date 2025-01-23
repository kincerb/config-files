local actions = require("fzf-lua").actions
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {
      defaults = {
        file_icons = "mini",
        previewer = "bat",
      },
      actions = {
        files = {
          true,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-x"] = actions.buf_del,
        },
        buffers = {
          true,
          ["ctrl-x"] = actions.buf_del,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
        },
      },
      winopts = {
        width = 0.8,
        height = 0.6,
      },
    },
  },
}
