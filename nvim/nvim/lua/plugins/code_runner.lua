return {
  {
    "CRAG666/code_runner.nvim",
    -- Lazy-load when opening a file with one of these filetypes…
    ft = { "python", "c", "cpp", "java", "rust" },

    -- …or when running one of these commands
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },

    config = function()
      require("code_runner").setup({
        -- choose mode: "float", "tab", etc. Optional. Default is fine.
        -- mode = "float",

        filetype = {
          python = "python3 -u",
          c = "cd $dir && gcc $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
          cpp = "cd $dir && g++ $fileName -o /tmp/$fileNameWithoutExt && /tmp/$fileNameWithoutExt",
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt",
          },
          rust = {
            "cd $dir &&",
            "rustc $fileName &&",
            "$dir/$fileNameWithoutExt",
          },
          -- add more filetypes/commands as you like
        },

        -- optional: default mode, terminal options, etc.
        -- term = { position = "bottom", size = 15 },
        -- float = { border = "rounded", width = 0.8, x = 0.1, y = 0.1 },
      })

      -- keybindings (you can adjust these to your preference)
      vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = true })
      -- vim.keymap.set("n", "<leader>rc", ":RunClose<CR>", { noremap = true, silent = true })
    end,
  },
}
