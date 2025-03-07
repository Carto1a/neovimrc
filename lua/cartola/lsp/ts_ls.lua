return function()
    local lsp_common = require('cartola.lsp.common')
    local lspconfig = require('lspconfig')

    print('lsp ts')

    local server_name = "ts_ls"
    local settings = lsp_common.get_servers_settings(server_name)
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

        configuration = lsp_common.deep_copy(configuration, vue_configuration)
    end

    lspconfig[server_name].setup(configuration)
end
