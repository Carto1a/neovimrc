---@type dap.Configuration[]
local vsdbg_configuration = {
    {
        name = "Launch - vsdbg",
        type = "coreclr",
        request = "launch",
        program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
        cwd = vim.fn.getcwd(),
        -- externalTerminal = true,
        columnsStartAt1 = true,
        linesStartAt1 = true,
        locale = "en",
        pathFormat = "path",
        console = "externalTerminal"
        -- externalConsole = true
        -- stopAtEntry = true
        -- console = "externalTerminal"
    }
}

require("dap").configurations.cs = vsdbg_configuration
