return function(server_name)
    local lspconfig = require('lspconfig')
    local common = require('cartola.lsp.common')

    local settings = common.get_servers_settings(server_name)
    local configuration = {
        capabilities = common.capabilities
    }

    if not common.server_have_config(settings) then
        lspconfig[server_name].setup(configuration)
        return
    end

    if not common.server_enabled(settings) then
        return
    end

    configuration = common.deep_copy(configuration, settings)

    lspconfig[server_name].setup(configuration)
end
