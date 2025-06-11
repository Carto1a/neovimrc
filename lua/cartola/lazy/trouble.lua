return {
    "folke/trouble.nvim",
    tag = "v3.7.1",
    cmd = "Trouble",
    lazy = false,
    keys = {
        { "<leader>[t", function() require("trouble").next({ skip_groups = true, jump = true }) end,     desc = "[t]rouble: [t]oggle list" },
        { "<leader>]t", function() require("trouble").previous({ skip_groups = true, jump = true }) end, desc = "[t]rouble: [t]oggle list" },

        { "<leader>tt", function() require("cartola.utils.util-trouble").open_menu() end,                                                      desc = "[t]rouble: [t]oggle list" },
        { "<leader>tw", function() require("cartola.utils.util-trouble").open_menu("diagnostics") end,                                         desc = "[t]rouble: [w]orkspace diagnostics list" },
        { "<leader>td", function() require("cartola.utils.util-trouble").open_menu("diagnostics_buffer") end,                                  desc = "[t]rouble: buffer [d]iagnostics list" },
        { "<leader>tq", function() require("cartola.utils.util-trouble").open_menu("quickfix") end,                                            desc = "[t]rouble: [q]uickfix list" },
        { "<leader>tl", function() require("cartola.utils.util-trouble").open_menu("loclist") end,                                             desc = "[t]rouble: [l]ocation list" },

        { "gr",         function() require("cartola.utils.util-trouble").open_menu("lsp_references") end,                                      desc = "trouble: [g]o to [r]eferences" },
        { "gd",         function() require("cartola.utils.util-trouble").open_menu("lsp_definitions") end,                                     desc = "trouble: [g]o to [d]efinition" },
        { "gi",         function() require("cartola.utils.util-trouble").open_menu("lsp_implementations") end,                                 desc = "trouble: [g]o to [i]mplementation" },
    },
    opts = {
        modes = {
            lsp_base = {
                focus = true,
                follow = false,
                auto_refresh = false,
                restore = true,
                params = {
                    include_current = false,
                },
            },
            lsp_references = {
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
    },
    config = function(_, opts)
        require("trouble").setup(opts)

        vim.api.nvim_create_autocmd("BufRead", {
            callback = function(args)
                if vim.bo[args.buf].buftype == "quickfix" then
                    vim.schedule(function()
                        vim.cmd([[cclose]])
                        require("cartola.utils.util-trouble").open_menu("quickfix")
                    end)
                end
            end,
        })
    end,
}
