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

    config = function()
        require("cartola.custom.project_config").setup({})

        require("mason-lspconfig").setup({
            automatic_enable = false,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "omnisharp",
                "zls",
            }
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "ConfigChange",
            callback = function()
                require("cartola.lsp.lsp").configure_servers()
                vim.cmd("LspRestart")
            end
        })
    end
}
