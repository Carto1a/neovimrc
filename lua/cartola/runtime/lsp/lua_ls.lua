local util = require("cartola.lsp")
local server_name = "lua_ls"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}

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
                        "${3rd}/luv/library"
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

    configuration = vim.tbl_deep_extend(
        "force",
        configuration,
        vim_configuration
    )
end

return configuration
