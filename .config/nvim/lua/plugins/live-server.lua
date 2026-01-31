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
    -- Configure live-server with custom options
    require("live-server").setup({
      port = 5555,
      browser = nil, -- nil uses system default browser
      open = true, -- auto-open browser on start
      ignore_patterns = { "node_modules", ".git", "__pycache__" },
    })
    -- Keybindings
    vim.keymap.set("n", "<leader>ps", ":LiveServerStart<CR>", { desc = "Start Live Server" })
    vim.keymap.set("n", "<leader>pc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })
  end,
}
