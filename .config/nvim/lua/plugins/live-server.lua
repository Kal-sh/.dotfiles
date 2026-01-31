return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  config = function()
    -- Configure live-server with custom options
    require("live-server").setup({
      port = 5555,
      browser = nil, -- nil uses system default browser
      open = true, -- auto-open browser on start
      watch = {
        "html",
        "css",
        "js",
        "jsx",
        "vue",
        "svelte",
      },
      ignore_patterns = { "node_modules", ".git", "__pycache__" },
    })
  end,
}
