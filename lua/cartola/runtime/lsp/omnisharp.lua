local util = require("cartola.lsp")
local server_name = "omnisharp"

local settings = util.get_servers_settings(server_name)

util.setup_default_settings(server_name, settings)

local configuration = {}

local ok, omnisharp_ext = pcall(require, "omnisharp_extended");

if ok then
    local handlers = {
        ["textDocument/definition"] = omnisharp_ext.definition_handler,
        ["textDocument/typeDefinition"] = omnisharp_ext.type_definition_handler,
        ["textDocument/references"] = omnisharp_ext.references_handler,
        ["textDocument/implementation"] = omnisharp_ext.implementation_handler,
    }

    configuration.handlers = handlers
end

return configuration
