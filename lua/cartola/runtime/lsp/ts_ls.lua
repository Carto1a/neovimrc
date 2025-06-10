local util = require("cartola.utils.util-lsp")
local server_name = "ts_ls"

local settings = util.get_servers_settings(server_name)

util.setup_default_settings(server_name, settings)

local configuration = {}

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

    configuration = vim.tbl_deep_extend(
        "force",
        configuration,
        vue_configuration
    )
end

return configuration
