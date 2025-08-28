local util = require("cartola.lsp")
local server_name = "omnisharp"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}

configuration.on_init = function(_)
    local ok, omnisharp_ext = pcall(require, "omnisharp_extended")
    if ok then
        vim.keymap.set('n', 'gd', omnisharp_ext.lsp_definition, { buffer = true })
    end
end

return configuration
