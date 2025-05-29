local M = {}

local handlers = {
    function(server_name)
        require('cartola.lsp.default')(server_name)
    end,

    ["lua_ls"] = function(server_name)
        require("cartola.lsp.default")(server_name, require("cartola.lsp.lua_ls"))
    end,

    ["ts_ls"] = function(server_name)
        require("cartola.lsp.default")(server_name, require("cartola.lsp.ts_ls"))
    end
}

function M.configure_servers()
    local installed_servers = require("mason-lspconfig").get_installed_servers()
    for _, server_name in pairs(installed_servers) do
        local handler = handlers[server_name]
        if handler then
            handler(server_name)
            return
        end

        handlers[1](server_name)
    end
end

return M
