local util = require("cartola.lsp")
local server_name = "omnisharp"

local settings = util.get_servers_settings(server_name)

util.setup_default_settings(server_name, settings)

local configuration = {}

return configuration
