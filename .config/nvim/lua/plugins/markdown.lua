-- Markdown preview configuration using render-markdown.nvim

return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Lazy-load the plugin for markdown files
  ft = { "markdown" },
  config = function()
    require("render-markdown").setup({
      -- Configure the 'glow' renderer for terminal-based markdown rendering
      renderers = {
        glow = {
          cmd = "glow",
          args = { "-s", "dark" }, -- Use a dark style for glow
          width = 100,            -- Set a default width
          height = 100,           -- Set a default height
          border = "rounded",
        },
      },
    })

  end,
}
