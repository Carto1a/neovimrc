return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "williamboman/mason-lspconfig.nvim",
            dependencies = { "williamboman/mason.nvim" },
        },
        -- 'hrsh7th/cmp-nvim-lsp',
        'saghen/blink.cmp',
        "j-hui/fidget.nvim",
        "folke/neoconf.nvim"
    },

    lazy = true,
    cmd = { "LspInfo" },
    event = "BufReadPre",

    config = function()
        require("fidget").setup({})

        local lsp_common = require('cartola.lsp.common')

        require("cartola.custom.project_config").setup({})

        local capabilities = lsp_common.capabilities

        require("lspconfig")["gdscript"].setup({
            filetypes = { "gd", "gdscript", "gdscript3" },
            capabilities = capabilities
        })

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

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "omnisharp",
                "zls",
            },
            handlers = handlers
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "ConfigChange",
            callback = function()
                local installed_servers = require("mason-lspconfig").get_installed_servers()
                for _, server_name in pairs(installed_servers) do
                    print(server_name)
                    local handler = handlers[server_name]
                    if handler then
                        handler(server_name)
                        return
                    end

                    handlers[1](server_name)
                end

                vim.cmd("LspRestart")
            end
        })
    end
}
