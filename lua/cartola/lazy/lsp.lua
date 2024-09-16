return {
    "neovim/nvim-lspconfig",
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "folke/neoconf.nvim"
    },

    config = function()
        require("fidget").setup({})
        require("mason").setup()
        require("neoconf").setup({})

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp.default_capabilities()
        )

        local function get_servers_settings(server_name)
            return require("neoconf").get("lspconfig." .. server_name) or {}
        end

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },

            virtual_text = true,
            signs = true,
            underline = false,
            severity_sort = false,
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
                    local settings = get_servers_settings(server_name)

                    local default_configuration = {
                        capabilities = capabilities
                    }

                    if next(settings) == nil then
                        lspconfig[server_name].setup(default_configuration)
                        return
                    end

                    if settings.enable ~= nil then
                        if not settings.enable then
                            return
                        end
                    end

                    local configuration = vim.tbl_deep_extend(
                        "force",
                        {},
                        default_configuration,
                        settings
                    )

                    lspconfig[server_name].setup(configuration)
                end,

                ["ts_ls"] = function()
                    local neoconf = require("neoconf")
                    local settings = neoconf.get("lspconfig.ts_ls") or {}
                    local lsp_configurations = {
                        capabilities = capabilities,
                    }

                    if settings.enable ~= nil then
                        if not settings.enable then
                            return
                        end
                    end

                    if next(settings) == nil then
                        lspconfig.ts_ls.setup(lsp_configurations)
                        return
                    end

                    local configuration = vim.tbl_deep_extend(
                        "force",
                        {},
                        lsp_configurations,
                        settings
                    )

                    if settings.vue then
                        local mason_registry = require('mason-registry')
                        local vue_language_server_path = mason_registry.get_package('vue-language-server')
                            :get_install_path() ..
                            '/node_modules/@vue/language-server'

                        local vue_configuration = {
                            init_options = {
                                plugins = {
                                    {
                                        name = "@vue/typescript-plugin",
                                        location = vue_language_server_path,
                                        languages = { "vue" },
                                    }
                                }
                            },
                            filetypes = { "typescript", "javascript", "vue" },
                        }

                        configuration = vim.tbl_deep_extend("force", configuration, vue_configuration)
                    end

                    lspconfig.ts_ls.setup(configuration)
                end,
            }
        })
    end
}
