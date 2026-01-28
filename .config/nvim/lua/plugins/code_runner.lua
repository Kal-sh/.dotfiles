return {
  {
    "CRAG666/code_runner.nvim",
    ft = { "python", "c", "cpp", "java", "rust" },
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" },
    config = function()
      require("code_runner").setup({
        mode = "float",

        float = {
          border = "rounded",
          width = 0.7,
          height = 0.7,
          -- these will be overridden below
          x = 0.5,
          y = 0.5,
        },

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
            "cd $dir && rustc $fileName &&",
            "$dir/$fileNameWithoutExt",
          },
        },
      })

      -- Center the float every time it opens
      -- See `:h nvim_open_win` for relative="editor"
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeRunnerFloatOpen",
        callback = function()
          local win = vim.api.nvim_get_current_win()
          local width = vim.o.columns
          local height = vim.o.lines

          local cfg = {
            relative = "editor",
            width = math.floor(width * 0.8),
            height = math.floor(height * 0.6),
            row = math.floor((height - (height * 0.6)) / 2),
            col = math.floor((width - (width * 0.8)) / 2),
            border = "rounded",
            style = "minimal",
          }

          vim.api.nvim_win_set_config(win, cfg)
        end,
      })

      -- keybinding
      vim.keymap.set("n", "<leader>rr", ":RunCode<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = true })
    end,
  },
}
