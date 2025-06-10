local opts = { silent = true }

-- Toggle dotfiles
vim.api.nvim_buf_set_keymap(0, "n", ".", "gh", opts)
-- Netrw folder navigation
vim.api.nvim_buf_set_keymap(0, "n", "l", "<cr>", opts)
vim.api.nvim_buf_set_keymap(0, "n", "h", "-", opts)
