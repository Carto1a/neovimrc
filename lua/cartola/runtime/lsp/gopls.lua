local util = require("cartola.lsp")
local server_name = "gopls"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}

print(vim.inspect(require("core.custom.project_config").configuration))

return configuration
