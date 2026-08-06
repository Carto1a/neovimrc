local config = require("internal.project_config")

local format_after_save_config = nil
local format_after_save = config.get("format_after_save")
if format_after_save then
    format_after_save_config = {
        timeout_ms = 1500,
        lsp_format = "fallback",
        async = true,
    }
end

return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    lazy = true,
    commit = "619363c",
    opts = {
        format_after_save = format_after_save_config,
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
