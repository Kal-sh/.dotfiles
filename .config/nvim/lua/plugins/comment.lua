-- lua/plugins/comment.lua
return {
  {
    "numToStr/Comment.nvim",
    -- Lazy-load when pressing Ctrl-/ in normal or visual mode:
    keys = {
      { "<C-/>", mode = { "n", "v" }, desc = "Toggle comment" },
    },
    opts = {
      padding = true,
      sticky = true,
      mappings = {
        basic = true,
        extra = true,
      },
      pre_hook = nil, -- no ts-context
    },
  },
}
