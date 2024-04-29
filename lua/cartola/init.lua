require("cartola.set")
require("cartola.auto")
require("cartola.remap")
require("cartola.netrw")
--require("cartola.statusline")
require("cartola.lazy_init")

local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup

vim.cmd.colorscheme("gruvbox-material")

autocmd('LspAttach', {
	group = autogroup('UserLspConfig', {}),
	callback = function(ev)
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>ws', function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>vca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
		vim.keymap.set('n', '<C-S-i>', function()
			vim.lsp.buf.format { async = true }
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	end,
})

autocmd('TextYankPost', {
    group = autogroup('UserTextYankPost', {}),
    callback = function(_)
        vim.highlight.on_yank({ timeout = 150 })
    end,
})
