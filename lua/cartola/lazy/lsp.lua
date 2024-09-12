return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
    },

    config = function()
        require("fidget").setup({})
        require("mason").setup()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local lspconfig = require("lspconfig")

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = false,
            update_in_insert = false,
            severity_sort = false,
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            }
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "omnisharp",
                "zls",
            },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({})
                end,

                ["omnisharp"] = function()
                    lspconfig.omnisharp.setup({
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        enable_import_completion = true,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                },
                                hint = {
                                    enable = true
                                }
                            }
                        }
                    })
                end
            }
        })
    end
}
