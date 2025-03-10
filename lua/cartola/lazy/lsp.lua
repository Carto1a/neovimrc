return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = { "williamboman/mason.nvim" },
        },
        -- 'hrsh7th/cmp-nvim-lsp',
        'saghen/blink.cmp',
        "j-hui/fidget.nvim",
        "folke/neoconf.nvim"
    },

    lazy = true,
    cmd = { "LspInfo" },
    event = "BufReadPre",

    config = function()
        require("fidget").setup({})
        -- TODO: understand how neoconf reload configuration
        require("neoconf").setup({})

        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("blink-cmp").get_lsp_capabilities()

        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_nvim_lsp
        )

        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        capabilities.textDocument.completion.completionItem.snippetSupport = true

        local function get_servers_settings(server_name)
            return require("neoconf").get("lspconfig." .. server_name) or {}
        end

        local function server_enabled(settings)
            if settings.enabled ~= nil then
                return settings.enabled
            end

            return true
        end

        local function server_have_config(settings)
            return next(settings) ~= nil
        end

        local function deep_copy(tbl1, tbl2)
            return vim.tbl_deep_extend(
                "force",
                {},
                tbl1,
                tbl2
            )
        end

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },

            virtual_text = true,
            signs = true,
            underline = false,
            severity_sort = false,
        })

        require("lspconfig")["gdscript"].setup({
            filetypes = { "gd", "gdscript", "gdscript3" },
            capabilities = capabilities
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
                    local configuration = {
                        capabilities = capabilities
                    }

                    if not server_have_config(settings) then
                        lspconfig[server_name].setup(configuration)
                        return
                    end

                    if not server_enabled(settings) then
                        return
                    end

                    configuration = deep_copy(configuration, settings)

                    lspconfig[server_name].setup(configuration)
                end,

                ["lua_ls"] = function()
                    local server_name = "lua_ls"
                    local settings = get_servers_settings(server_name)
                    local configuration = {
                        capabilities = capabilities,
                    }

                    if not server_have_config(settings) then
                        lspconfig[server_name].setup(configuration)
                        return
                    end

                    if not server_enabled(settings) then
                        return
                    end

                    configuration = deep_copy(configuration, settings)

                    if settings.vim and settings.vim.enabled then
                        local vim_configuration = {
                            settings = {
                                Lua = {
                                    runtime = {
                                        version = 'LuaJIT',
                                    },
                                    workspace = {
                                        library = {
                                            vim.env.VIMRUNTIME,
                                        }
                                    }
                                }
                            },
                        }

                        if settings.vim.plugins ~= nil then
                            local lib_path_table = vim_configuration.settings.Lua.workspace.library;
                            local lazy_plugin_path = vim.fn.stdpath("data") .. "/lazy/"

                            for _, value in pairs(settings.vim.plugins) do
                                -- NOTE: check if file exists?
                                table.insert(lib_path_table, lazy_plugin_path .. value)
                            end
                        end

                        configuration = deep_copy(configuration, vim_configuration)
                    end

                    lspconfig.lua_ls.setup(configuration)
                end,

                ["ts_ls"] = function()
                    local server_name = "ts_ls"
                    local settings = get_servers_settings(server_name)
                    local configuration = {
                        capabilities = capabilities,
                    }

                    if not server_have_config(settings) then
                        lspconfig[server_name].setup(configuration)
                        return
                    end

                    if not server_enabled(settings) then
                        return
                    end

                    configuration = deep_copy(configuration, settings)

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

                        configuration = deep_copy(configuration, vue_configuration)
                    end

                    lspconfig.ts_ls.setup(configuration)
                end,
            }
        })
    end
}
