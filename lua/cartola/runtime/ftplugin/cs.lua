if vim.b.did_ftplugin == true then
    return
end

vim.b.did_ftplugin = true

local opts = { buffer = true }

vim.keymap.set('n', 'gd', require('omnisharp_extended').lsp_definition, opts)
