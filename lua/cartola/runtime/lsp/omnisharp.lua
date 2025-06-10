local util = require("cartola.utils.util-lsp")
local server_name = "omnisharp"

local settings = util.get_servers_settings(server_name)

util.setup_default_settings(server_name, settings)

local configuration = {}

local omnisharp = require("omnisharp_extended");

local handlers = {
    ["textDocument/definition"] = omnisharp.definition_handler,
    ["textDocument/typeDefinition"] = omnisharp.type_definition_handler,
    ["textDocument/references"] = omnisharp.references_handler,
    ["textDocument/implementation"] = omnisharp.implementation_handler,
}

configuration.handlers = handlers

return configuration
