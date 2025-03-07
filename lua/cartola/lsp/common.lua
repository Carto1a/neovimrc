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
    return require("neoconf").get("lspconfig." .. server_name) or {}
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

function M.deep_copy(tbl1, tbl2)
    return vim.tbl_deep_extend(
        "force",
        {},
        tbl1,
        tbl2
    )
end

return M
