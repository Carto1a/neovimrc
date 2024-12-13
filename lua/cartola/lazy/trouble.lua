return {
    "folke/trouble.nvim",
    -- tag = "v2.10.0",
    tag = "v3.6.0",
    config = function()
        local setmap = vim.keymap.set
        local open_menu = require("cartola.utils.util-trouble").open_menu;
        local trouble = require("trouble")
        trouble.setup({
            -- icons = false,
        })

        setmap("n", "<leader>tt", function() open_menu() end)
        setmap("n", "<leader>tw", function() open_menu("workspace_diagnostics") end)
        setmap("n", "<leader>td", function() open_menu("document_diagnostics") end)
        setmap("n", "<leader>tq", function() open_menu("quickfix") end)
        setmap("n", "<leader>tl", function() open_menu("loclist") end)
        setmap("n", "<leader>[t", function() trouble.next({ skip_groups = true, jump = true }) end)
        setmap("n", "<leader>]t", function() trouble.previous({ skip_groups = true, jump = true }) end)
        setmap("n", "gr", function() open_menu("lsp_references") end)
        setmap("n", "gd", function() open_menu("lsp_definitions") end)
        setmap("n", "gi", function() open_menu("lsp_implementations") end)
    end,
}
