return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                'saghen/blink.cmp',
                { "j-hui/fidget.nvim", opts = {} },
            }
        }
    },
    opts = {
        automatic_enable = false,
        ensure_installed = {
            "lua_ls",
            "rust_analyzer",
            "ts_ls",
            "omnisharp",
            "zls",
        }
    },
    config = function(_, opts)
        require("cartola.custom.project_config").setup({})

        require("mason-lspconfig").setup(opts)

        vim.api.nvim_create_autocmd("User", {
            pattern = "ConfigChange",
            callback = function()
                vim.lsp.stop_client(vim.lsp.get_clients())
                vim.cmd.edit()
            end
        })
    end
}
