local M = {}

local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("blink-cmp").get_lsp_capabilities()
)

capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.capabilities = capabilities;

function M.get_servers_settings(server_name)
    return require("cartola.custom.project_config").get("lspconfig." .. server_name) or {}
end

function M.server_enabled(settings)
    if settings.enabled ~= nil then
        return settings.enabled
    end

    return true
end

function M.server_have_config(settings)
    return next(settings) ~= nil
end

function M.merge_table(tbl1, tbl2)
    return vim.tbl_deep_extend(
        "force",
        {},
        tbl1,
        tbl2
    )
end

function M.setup_configuration(server_name, configuration)
    configuration.internal = nil
    vim.lsp.config(server_name, configuration)
end

return M
