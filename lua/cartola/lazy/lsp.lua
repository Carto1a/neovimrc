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
        -- TODO: understand how neoconf reload configuration
        require("neoconf").setup({})

        local common = require('cartola.lsp.common')

        require("cartola.custom.project_config").setup({})
        print(require("cartola.custom.project_config").get("config"))

        local capabilities = common.capabilities

        require("lspconfig")["gdscript"].setup({
            filetypes = { "gd", "gdscript", "gdscript3" },
            capabilities = capabilities
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "omnisharp",
                "zls",
            },
            handlers = {
                require('cartola.lsp.default'),

                ["lua_ls"] = require('cartola.lsp.lua_ls'),

                ["ts_ls"] = require('cartola.lsp.ts_ls'),
            }
        })
    end
}
