return function(settings)
    local lsp_common = require('cartola.lsp.common')
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

        return vue_configuration
    end

    return configuration
end
