return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    lazy = true,
    opts =
    {
        -- format_after_save = {
        --     timeout_ms = 1500,
        --     lsp_format = "fallback",
        --     async = true,
        -- },
        formatters_by_ft = {
            lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            -- You can customize some of the format options for the filetype (:help conform.format)
            rust = { "rustfmt", lsp_format = "fallback" },
            -- Conform will run the first available formatter
            javascript = { "prettier", "prettierd", stop_after_first = true },
            typescript = { "prettier", "prettierd", stop_after_first = true },
            vue = { "prettier", "prettierd", stop_after_first = true },
            css = { "prettier", "prettierd", stop_after_first = true },
            json = { "prettier", "prettierd", stop_after_first = true },
        },
    }
}
