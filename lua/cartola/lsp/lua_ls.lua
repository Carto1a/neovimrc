return function()
    local lsp_common = require('cartola.lsp.common')
    local lspconfig = require('lspconfig')

    local server_name = "lua_ls"
    local settings = require("neoconf").get("lspconfig." .. server_name) or {}
    local configuration = {
        capabilities = lsp_common.capabilities,
    }

    if not lsp_common.server_have_config(settings) then
        lspconfig[server_name].setup(configuration)
        return
    end

    if not lsp_common.server_enabled(settings) then
        return
    end

    configuration = lsp_common.deep_copy(configuration, settings)

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

        configuration = lsp_common.deep_copy(configuration, vim_configuration)
    end

    lspconfig[server_name].setup(configuration)
end
