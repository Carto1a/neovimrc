local util = require("cartola.lsp")
local server_name = "roslyn_ls"

local settings = util.get_servers_settings(server_name)

util.setup_default_settings(server_name, settings)

local configuration = {
    -- settings = {
    --     flags = {
    --         allow_incremental_sync = false,
    --     },
    -- }
}

return configuration
