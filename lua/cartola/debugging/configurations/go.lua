require("dap").configurations.go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${workspaceFolder}"
    },
    -- {
    --     type = "delve",
    --     name = "Debug test", -- configuration for debugging test files
    --     request = "launch",
    --     mode = "test",
    --     program = "${file}"
    -- },
    -- -- works with go.mod packages and sub packages
    -- {
    --     type = "delve",
    --     name = "Debug test (go.mod)",
    --     request = "launch",
    --     mode = "test",
    --     program = "./${relativeFileDirname}"
    -- }
}
