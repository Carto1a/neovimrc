local dap = require("dap")
local dap_utils = require('dap.utils')
local rpc = require('dap.rpc')

-- vsdbg certification
local function send_payload(client, payload)
    local msg = rpc.msg_with_content_length(vim.json.encode(payload))
    client.write(msg)
end

function RunHandshake(self, request_payload)
    local signjs = vim.g.PATH.NVIM_CONFIG .. "/lua/" .. vim.g.PROFILE .. "/debugging" .. "/vsdbgsignature.js"

    local signResult = io.popen("node " ..
        signjs ..
        " \"C:\\Users\\cepleite\\AppData\\Local\\Programs\\Microsoft VS Code\"" .. " " .. request_payload.arguments.value)
    if signResult == nil then
        dap_utils.notify('error while signing handshake', vim.log.levels.ERROR)
        return
    end

    local signature = signResult:read("*a")
    signature = signature:gsub('\n', ''):gsub("\"", "")
    local response = {
        type = "response",
        seq = 0,
        command = "handshake",
        request_seq = request_payload.seq,
        success = true,
        body = {
            signature = signature
        }
    }
    send_payload(self.client, response)
end

local vsdbg_path = vim.g.PATH.HOME ..
    "/.vscode/extensions/ms-dotnettools.csharp-2.80.16-win32-x64/.debugger/x86_64/vsdbg.exe"

---@class dap.ExecutableAdapter
local vsdbg_coreclr_adapter = {
    id = 'coreclr',
    type = 'executable',
    command = vsdbg_path,
    args = {
        "--interpreter=vscode"
        -- "--engineLogging",
        -- "--consoleLogging",
    },
    options = {
        -- externalTerminal = true,
        detached = false,
        logging = {
            moduleLoad = false,
            trace = true
        }
    },
    runInTerminal = true,
    reverse_request_handlers = {
        handshake = RunHandshake
    }
}

dap.adapters.coreclr = vsdbg_coreclr_adapter

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

dap.configurations.cs = vsdbg_configuration
