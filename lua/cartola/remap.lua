vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("x", "<C-c>", ':%y+<cr>', {noremap=true, silent=true})

-- Mapeamentos em modo de inserção
map('i', "''<tab>", "''<left>", opts)
map('i', '`<tab>', "``<left>", opts)
map('i', '""<tab>', '""<left>', opts)
map('i', '()<tab>', '()<left>', opts)
map('i', '[]<tab>', '[]<left>', opts)
map('i', '{}<tab>', '{}<left>', opts)

map('i', "',<tab>", "',<left><left>", opts)
map('i', "`,<tab>", "`,<left><left>", opts)
map('i', "\",<tab>", "\"\",<left><left>", opts)
map('i', '(,<tab>', '(),<left><left>', opts)
map('i', '[,<tab>', '[],<left><left>', opts)
map('i', '{,<tab>', "{}<left><left>", opts)

map('i', "\"<cr>", "\"<CR>\"<esc>O", opts)
map('i', "'<cr>", "'<cr>'<esc>O", opts)
map('i', '`<cr>', '`<cr>`<esc>O', opts)
map('i', '"<cr>', '"<cr>"<esc>O', opts)
map('i', '(<cr>', '()<cr>)<esc>O', opts)
map('i', '[<cr>', '[<cr>]<esc>O', opts)
map('i', '{<cr>', '{<cr><backspace>}<esc>O', opts)

-- Limpar destaque ao pressionar Enter no modo normal
map('n', '<CR>', ':noh<CR><CR>', opts)
map('n', '<esc>', '<esc>^[ <esc>^[:noh<CR>', opts)

-- Mapeamentos de navegação entre janelas
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-l>', '<C-w>l', opts)
map('n', '<C-j>', '<C-w>j', opts)

-- Mapeamentos de navegação rápida
--map('i', 'jj', '<esc>', opts)
map('i', '<C-h>', '<Left>', opts)
map('i', '<C-j>', '<Down>', opts)
map('i', '<C-k>', '<Up>', opts)
map('i', '<C-l>', '<Right>', opts)
map('i', '<C-4>', '<End>', opts)
map('i', '<C-0>', '<Home>', opts)
map('i', '<C-_>', '<esc><S-_>i', opts)

-- TODO: if eof make more lines
map('i', '<A-j>', ':m .+1<cr>==', opts)
map('i', '<A-k>', ':m .-2<cr>==', opts)
map('n', '<A-j>', ':m .+1<cr>==', opts)
map('n', '<A-k>', ':m .-2<cr>==', opts)
map('x', '<A-j>', ':m \'>+1<cr>gv=gv', opts)
map('x', '<A-k>', ':m -2<cr>gv=gv', opts)


