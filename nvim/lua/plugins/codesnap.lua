return {
  "mistricky/codesnap.nvim",
  build = "make",
  keys = {
    { "<c-p>", "<cmd>CodeSnap<cr>", mode = "x", desc = "Copy selected code snapshot into clipboard" },
    { "<c-P>", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot" },
  },
  opts = {
    save_path = "~/Pictures",
    has_breadcrumbs = true,
    bg_color = "#535c68",
    title = "",
    watermark = "",
  },
}
