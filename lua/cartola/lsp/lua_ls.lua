return function(settings)
    local lsp_common = require('cartola.lsp.common')
    local configuration = {}

    if settings.internal.vim and settings.internal.vim.enabled then
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

        if settings.internal.vim.plugins ~= nil then
            local lib_path_table = vim_configuration.settings.Lua.workspace.library;
            local lazy_plugin_path = vim.fn.stdpath("data") .. "/lazy/"

            for _, value in pairs(settings.internal.vim.plugins) do
                -- NOTE: check if file exists?
                table.insert(lib_path_table, lazy_plugin_path .. value)
            end
        end

        return vim_configuration
    end

    return configuration
end
