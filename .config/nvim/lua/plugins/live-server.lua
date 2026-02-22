return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  ft = {
    "html",
    "css",
    "js",
    "jsx",
    "vue",
    "svelte",
  },
  config = function()
    require("live-server").setup({
      host = "0.0.0.0", -- 🔑 bind to all interfaces
      port = 5555,
      browser = nil, -- use system default browser
      open = true, -- try to auto open browser (but often not supported in containers)
      ignore_patterns = { "node_modules", ".git", "__pycache__" },
    })

    vim.keymap.set("n", "<leader>ps", ":LiveServerStart<CR>", { desc = "Start Live Server" })
    vim.keymap.set("n", "<leader>pc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })
  end,
}
