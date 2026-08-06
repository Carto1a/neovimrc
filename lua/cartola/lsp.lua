local M = {}

function M.get_servers_settings(server_name)
    return require("internal.project_config").get("lspconfig." .. server_name) or {}
end

local servers = require("internal.project_config").get("lspconfig.enableds") or {}
vim.lsp.enable(servers)

return M
