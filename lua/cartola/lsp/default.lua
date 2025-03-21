return function(server_name, load_custom_config)
    local lsp_common = require('cartola.lsp.common')

    local settings = lsp_common.get_servers_settings(server_name)
    local configuration = {
        capabilities = lsp_common.capabilities
    }

    if not lsp_common.server_have_config(settings) then
        lsp_common.setup_configuration(server_name, configuration)
        return
    end

    if settings.internal ~= nil then
        if not lsp_common.server_enabled(settings.internal) then
            return
        end
    end

    configuration = lsp_common.merge_table(configuration, settings)

    local custom_configuration = nil;
    if load_custom_config then
        custom_configuration = load_custom_config(settings)
    end

    configuration = lsp_common.merge_table(configuration, custom_configuration)

    lsp_common.setup_configuration(server_name, configuration)
end
