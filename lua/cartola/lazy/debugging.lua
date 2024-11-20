return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "williamboman/mason.nvim",
    },
    keys = {
        { "<leader>d",  "",                                                                                   desc = "+debug",                 mode = { "n", "v" } },
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<F9>",       function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
        { "<F5>",       function() require("dap").continue() end,                                             desc = "Continue" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<F11>",      function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<S-F11>",    function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<F10>",      function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<S-F5>",     "<cmd>DapTerminate<cr>",                                                              desc = "Terminate" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
        { "<C-S-F5>",   function() require("dap").restart() end,                                              desc = "Reload" },
    },
    lazy = true,
    config = function()
        local mason_registry = require('mason-registry')
        local dap = require("dap")

        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
        local icons = {
            Stopped             = { "→", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint          = " ",
            BreakpointCondition = " ",
            BreakpointRejected  = { " ", "DiagnosticError" },
            LogPoint            = ".>",
        }

        for name, sign in pairs(icons) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end

        -- dap.defaults.fallback.on_output = function(session, output_event) end

        dap.defaults.fallback.external_terminal = {
            command = '/usr/bin/kitty',
            args = { '-e' },
        }

        dap.defaults.fallback.force_external_terminal = true

        local vscode_dap = mason_registry.get_package('js-debug-adapter')
            :get_install_path() ..
            '/js-debug/src/dapDebugServer.js'
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { vscode_dap, "${port}" }
            }
        }

        dap.configurations.javascript = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                console = "externalTerminal",
                program = "${file}",
                cwd = "${workspaceFolder}"
            }
        }
    end
}
