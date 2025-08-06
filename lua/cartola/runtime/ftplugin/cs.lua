if vim.b.did_ftplugin == true then
    return
end

vim.b.did_ftplugin = true

-- local ok, omnisharp_ext = pcall(require, "omnisharp_extended")
-- if ok then
--     vim.keymap.set('n', 'gd', omnisharp_ext.lsp_definition, { buffer = true })
-- end
