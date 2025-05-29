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

    -- lazy = true,
    -- cmd = { "LspInfo" },
    -- event = "BufReadPre",

    config = function()
        require("fidget").setup({})

        local lsp_common = require('cartola.lsp.common')

        require("cartola.custom.project_config").setup({})

        local capabilities = lsp_common.capabilities

        require("lspconfig")["gdscript"].setup({
            filetypes = { "gd", "gdscript", "gdscript3" },
            capabilities = capabilities
        })

        require("mason-lspconfig").setup({
            automatic_enable = false,
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "ts_ls",
                "omnisharp",
                "zls",
            }
        })

        vim.api.nvim_create_autocmd("User", {
            pattern = "ConfigChange",
            callback = function()
                require("cartola.lsp.lsp").configure_servers()
                vim.cmd("LspRestart")
            end
        })
    end
}
