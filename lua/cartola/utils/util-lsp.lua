local M = {}

vim.g.lsp = {}

---@param server_name string
function M.setup_default_settings(server_name, settings)
    vim.g.lsp[server_name] = true

    if not M.server_have_config(settings) then return end

    if not settings.enabled then
        vim.g.lsp.omnisharp = false
        return
    end

    if settings.internal ~= nil then
        vim.lsp.config(server_name, settings.internal)
    end
end

function M.get_servers_settings(server_name)
    return require("cartola.custom.project_config").get("lspconfig." .. server_name) or {}
end

function M.server_have_config(settings)
    return next(settings) ~= nil
end

function M.server_enabled(settings)
    if settings.enabled ~= nil then
        return settings.enabled
    end

    return true
end

return M
