local util = require("cartola.lsp")
local server_name = "ts_ls"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}

if settings.vue then
    local vue_language_server_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")

    local vue_configuration = {
        init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = vue_language_server_path,
                    languages = { "vue" },
                    configNamespace = 'typescript',
                }
            }
        },
        filetypes = { "typescript", "javascript", "vue" },
    }

    configuration = vim.tbl_deep_extend(
        "force",
        configuration,
        vue_configuration
    )
end

return configuration
