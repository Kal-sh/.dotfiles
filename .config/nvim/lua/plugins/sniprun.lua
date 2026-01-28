return {
  {
    "michaelb/sniprun",
    build = "bash ./install.sh",

    -- load when editing the following file types
    ft = {
      "markdown",
      "text",
      "python",
      "javascript",
      "typescript",
    },

    config = function()
      require("sniprun").setup({
        selected_interpreters = { "Python3_fifo", "JS_TS_deno" },
        repl_enable = { "Python3_fifo", "JS_TS_deno" },
      })

      vim.keymap.set("v", "<leader>rs", ":'<,'>SnipRun<CR>", { silent = true })
      vim.keymap.set("n", "<leader>rs", "<cmd>SnipRun<CR>", { silent = true })
      vim.keymap.set("n", "<leader>rc", "<cmd>SnipClose<CR>", { silent = true })
      vim.keymap.set("n", "<leader>rz", "<cmd>SnipReset<CR>", { silent = true })
    end,
  },
}
