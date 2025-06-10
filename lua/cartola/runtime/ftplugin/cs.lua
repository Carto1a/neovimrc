if vim.b.did_ftplugin == true then
    return
end

vim.b.did_ftplugin = true

local opts = { buffer = true }

vim.keymap.set('n', 'gd', require('omnisharp_extended').lsp_definition, opts)
-- vim.keymap.set('n', 'gr', require('omnisharp_extended').lsp_references, opts)
-- vim.keymap.set('n', 'gi', require('omnisharp_extended').lsp_implementation, opts)
