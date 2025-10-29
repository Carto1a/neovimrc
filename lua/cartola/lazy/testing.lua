local async = require("nio").tests

local t = function()
    return {
        name = "fake",
        is_test_file = function(file)
            return file:match("_test%.lua$") ~= nil
        end,
        discover_positions = function(path)
            return {
                type = "file",
                path = path,
                children = {
                    {
                        type = "test",
                        id = "fake_test_1",
                        name = "Fake test always passes",
                        path = path,
                        range = { 0, 0, 0, 0 },
                    },
                },
            }
        end,
        build_spec = function()
            return {
                command = "echo",
                args = { "ok" },
            }
        end,
        results = function()
            return {
                ["fake_test_1"] = { status = "passed" },
            }
        end,
    }
end




local neotest = {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nsidorenco/neotest-vstest",
        "mfussenegger/nvim-dap"
    },

    lazy = false,

    ---@type neotest.CoreConfig
    opts = {
        adapters = {
            t()
        },
        -- discovery = {
        --     enabled = true,
        --     concurrent = 2,
        -- },
        -- strategies = {
        -- },
        -- running = {
        --     concurrent = true
        -- },
        default_strategy = "dap",
        log_level = vim.log.levels.DEBUG
    }
}

local adapters = {
    { "nsidorenco/neotest-vstest", commit = "796e71f" }
}

return { adapters, neotest }
