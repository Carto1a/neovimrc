local M = {}

function M.get_servers_settings(server_name)
    return require("core.custom.project_config").get("lspconfig." .. server_name) or {}
end

local servers = require("core.custom.project_config").get("lspconfig.enableds") or {}
vim.lsp.enable(servers)

return M
