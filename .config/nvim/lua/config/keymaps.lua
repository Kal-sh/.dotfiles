-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Keybindings
vim.keymap.set("n", "<leader>ps", ":LiveServerStart<CR>", { desc = "Start Live Server" })
vim.keymap.set("n", "<leader>pc", ":LiveServerStop<CR>", { desc = "Stop Live Server" })
