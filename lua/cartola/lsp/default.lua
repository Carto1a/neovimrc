return function(server_name, load_custom_config)
    local lsp_common = require('cartola.lsp.common')

    local settings = lsp_common.get_servers_settings(server_name)
    local default_configuration = vim.lsp.config[server_name] or {}
    local configuration = lsp_common.merge_table(default_configuration, lsp_common.capabilities)

    if not lsp_common.server_have_config(settings) then
        lsp_common.setup_configuration(server_name, configuration)
        vim.lsp.enable(server_name)
        return
    end

    configuration = lsp_common.merge_table(configuration, settings)

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
    vim.lsp.enable(server_name)
end
