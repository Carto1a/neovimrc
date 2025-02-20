vim.g.mapleader = " "

local map = vim.keymap.set

local opts = { noremap = true, silent = true }

map("n", "<leader>pv", vim.cmd.Ex)

-- UpperCase Navigation
map('n', '<c-l>', function() require("cartola.custom.uppercasenavigation").Jump_to_uppercase(false) end, opts)
map('n', '<c-h>', function() require("cartola.custom.uppercasenavigation").Jump_to_uppercase(true) end, opts)

-- Mapeamentos em modo de inserção
map('i', "'<tab>", "''<left>", opts)
map('i', '`<tab>', "``<left>", opts)
map('i', '"<tab>', '""<left>', opts)
map('i', '(<tab>', '()<left>', opts)
map('i', '[<tab>', '[]<left>', opts)
map('i', '{<tab>', '{}<left>', opts)

-- TODO: procurar ou escrever um plugin para isso
map('i', "<<tab>", "<><left>", opts)
map('i', "<><tab>", "<></><left><left><left>", opts)
map('i', "</<tab>", "</><left><left>", opts)

map('i', "',<tab>", "'',<left><left>", opts)
map('i', "`,<tab>", "``,<left><left>", opts)
map('i', "\",<tab>", "\"\",<left><left>", opts)
map('i', '(,<tab>', '(),<left><left>', opts)
map('i', '[,<tab>', '[],<left><left>', opts)
map('i', '{,<tab>', "{}<left><left>", opts)

map('i', "\"<cr>", "\"<CR>\"<esc>O<tab>", opts)
map('i', "'<cr>", "'<cr>'<esc>O<tab>", opts)
map('i', '`<cr>', '`<cr>`<esc>O<tab>', opts)
map('i', '"<cr>', '"<cr>"<esc>O<tab>', opts)
map('i', '(<cr>', '(<cr>)<esc>O<tab>', opts)
map('i', '[<cr>', '[<cr>]<esc>O<tab>', opts)
map('i', '{<cr>', '{<cr>}<esc>O', opts)

-- TODO: procurar ou escrever um plugin para isso
map('i', '</<cr>', '<<cr>/><esc>O<tab>', opts)
map('i', '<<cr>', '<><cr></><esc>O<tab>', opts)

-- Limpar destaque ao pressionar Esc no modo normal
map('n', '<esc>', '<cmd>noh<cr><esc>', opts)

-- Mapeamentos de navegação rápida
map('i', '<c-h>', '<left>', opts)
map('i', '<c-j>', '<down>', opts)
map('i', '<c-k>', '<up>', opts)
map('i', '<c-l>', '<right>', opts)

-- NOTE: não funciona no windows terminal
map('i', '<c-4>', '<end>', opts)
map('i', '<c-0>', '<home>', opts)

-- TODO: if eof make more lines
map('n', '<a-j>', '<cmd>m .+1<cr>==', opts)
map('i', '<a-k>', '<esc><cmd>m .-2<cr>==', opts)
map('i', '<a-j>', '<esc><cmd>m .+1<cr>==', opts)
map('n', '<a-k>', '<cmd>m .-2<cr>==', opts)
map('x', '<a-j>', '<cmd>m \'>+1<cr>gv=gv', opts)
map('x', '<a-k>', '<cmd>m -2<cr>gv=gv', opts)

-- System clipboard
map('n', '<leader>y', '"+y', opts)
map('v', '<leader>y', '"+y', opts)
map('n', '<leader>p', '"+p', opts)
map('v', '<leader>p', '"+p', opts)
