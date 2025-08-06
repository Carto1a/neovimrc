local util = require("cartola.lsp")
local server_name = "roslyn_ls"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}

return configuration
