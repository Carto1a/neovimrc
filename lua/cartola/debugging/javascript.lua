-- local vscode_dap = mason_registry.get_package('js-debug-adapter')
--     :get_install_path() ..
--     '/js-debug/src/dapDebugServer.js'
--
-- dap.adapters["pwa-node"] = {
--     type = "server",
--     host = "localhost",
--     port = "${port}",
--     executable = {
--         command = "node",
--         args = { vscode_dap, "${port}" }
--     }
-- }



-- local vscode_dap = mason_registry.get_package('js-debug-adapter')
--     :get_install_path() ..
--     '/js-debug/src/dapDebugServer.js'


-- dap.configurations.javascript = {
--     {
--         type = "pwa-node",
--         request = "launch",
--         name = "Launch file",
--         console = "externalTerminal",
--         program = "${file}",
--         cwd = "${workspaceFolder}"
--     }
-- }
