return {
    "neovim/nvim-lspconfig",
    config = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "ConfigChange",
            callback = function()
                vim.lsp.stop_client(vim.lsp.get_clients())
                vim.cmd.edit()
            end
        })
    end
}
