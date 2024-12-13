return {
    "folke/trouble.nvim",
    -- tag = "v2.10.0",
    tag = "v3.6.0",
    config = function()
        local setmap = vim.keymap.set
        local open_menu = require("cartola.utils.util-trouble").open_menu;
        local trouble = require("trouble")
        trouble.setup({
            modes = {
                lsp_base = {
                    focus = true,
                    params = {
                        include_current = false,
                    },
                },
                lsp_references = {
                    -- auto_refresh = false,
                    params = {
                        include_declaration = true,
                    },
                    events = {
                        -- -- NOTE: uma boa ideia?
                        -- { event = "TextChanged", main = true },
                        -- { event = "LspAttach",   main = true },
                    }
                },
                diagnostics_buffer = {
                    mode = "diagnostics",
                    filter = { buf = 0 },
                    groups = {
                        { "filename", format = "{file_icon} {basename:Title} {count}" },
                    },
                }
            }
        })

        setmap("n", "<leader>tt", function() open_menu() end)
        setmap("n", "<leader>tw", function() open_menu("diagnostics") end)
        setmap("n", "<leader>td", function() open_menu("diagnostics_buffer") end)
        setmap("n", "<leader>tq", function() open_menu("quickfix") end)
        setmap("n", "<leader>tl", function() open_menu("loclist") end)
        setmap("n", "<leader>[t", function() trouble.next({ skip_groups = true, jump = true }) end)
        setmap("n", "<leader>[t", function() trouble.next({ skip_groups = true, jump = true }) end)
        setmap("n", "<leader>[t", function() trouble.next({ skip_groups = true, jump = true }) end)
        setmap("n", "<leader>]t", function() trouble.previous({ skip_groups = true, jump = true }) end)
        setmap("n", "gr", function() open_menu("lsp_references") end)
        setmap("n", "gd", function() open_menu("lsp_definitions") end)
        setmap("n", "gi", function() open_menu("lsp_implementations") end)
    end,
}
