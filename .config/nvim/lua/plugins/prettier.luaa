-- Configure vim-prettier in a separate Lua file
return {
  "prettier/vim-prettier",
  run = "pnpm add -g prettier", -- Install Prettier using pnpm
  ft = { "javascript", "typescript", "html", "css", "json", "markdown" }, -- File types to apply Prettier
  config = function()
    -- Keybinding for Prettier formatting
    vim.api.nvim_set_keymap("n", "<leader>pp", ":Prettier<CR>", { noremap = true, silent = true })

    -- Auto-format on save
    vim.cmd([[
      autocmd BufWritePre *.js,*.ts,*.md,*.jsx,*.tsx,*.css,*.html,*.json Prettier
    ]])

    -- Optional: Customize Prettier settings (e.g., tab width, single quote, etc.)
    vim.g["prettier#config#tab_width"] = 2
    vim.g["prettier#config#single_quote"] = 1
    vim.g["prettier#config#trailing_comma"] = "all"
  end,
}
