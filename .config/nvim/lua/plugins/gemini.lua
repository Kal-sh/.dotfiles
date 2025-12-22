return {
  "marcinjahn/gemini-cli.nvim",
  config = function()
    require("gemini_cli").setup({
      -- your configuration goes here
    })
  end,
  keys = {
    { "<leader>ga", "<cmd>Gemini<cr>", desc = "Open Gemini" },
  },
}
