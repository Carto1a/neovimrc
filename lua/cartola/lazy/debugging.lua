return {
	'rcarriga/nvim-dap-ui',
	dependencies = {
		'mfussenegger/nvim-dap',
	},
	config = function()
		-- local dapui = require("dapui")
		local dap = require("dap")
		local dap_widgets = require("dap.ui.widgets")
		-- dapui.setup()
		-- dap.listeners.before.attach.dapui_config = function ()
		-- 	dapui.open()
		-- end
		-- dap.listeners.before.launch.dapui_config = function ()
		-- 	dapui.open()
		-- end
		-- dap.listeners.before.event_terminated.dapui_config = function ()
		-- 	dapui.close()
		-- end
		-- dap.listeners.before.event_exited.dapui_config = function ()
		-- 	dapui.close()
		-- end

		dap.defaults.fallback.external_terminal = {
			command = '/usr/bin/kitty',
			args = { '-e' }
		}
		dap.defaults.fallback.force_external_terminal = true
		dap.defaults.fallback.focus_terminal = true
		dap.adapters["node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}"
				}
				-- TODO: adicionar o cwd depois, Working directory
				-- cwd = ""
			}
		}
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					os.getenv("HOME") .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
					"${port}"
				}
				-- TODO: adicionar o cwd depois, Working directory
				-- cwd = ""
			}
		}
		dap.adapters.python = {
			type = 'executable',
			command = os.getenv("HOME") .. './virtualenvs/tools/bin/python',
			args = { '-m', 'debugpy.adapter' },
		}

		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				cwd = "${workspaceFolder}",
				--console = "integratedTerminal",
			},
		}
		dap.configurations.typescript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Current File (pwa-node with ts-node)",
				cwd = vim.fn.getcwd(),
				runtimeExecutable = 'ts-node',
				--runtimeArgs = { '--esm' },
				program = "${file}",
				--args = { '${file}' },
				sourceMaps = true,
				protocol = 'inspector',
				skipFiles = { '<node_internal>/**', 'node_modules/**' },
				resolveSourceMapLocations = {
					'${workspaceFolder}/**',
					'!**/node_modules/**',
				},
			},
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Current File (pwa-node with tsc)",
				cwd = vim.fn.getcwd(),
				program = "${file}",
			},
		}
		dap.configurations.python = {
			type = 'python',
			request = 'launch',
			program = "${file}",
			pythonPath = function()
				return '/usr/bin/python'
			end
		}

		vim.keymap.set('n', '<leader>dc', function()
			if vim.fn.filereadable(".vscode/launch.json") then
				require("dap.ext.vscode").load_launchjs(nil, {
					node = {
						"javascript",
						"typescript"
					},
				})
			end
			dap.continue()
		end)
		vim.keymap.set('n', '<leader>dr', dap.restart)
		vim.keymap.set('n', '<leader>dt', dap.terminate)
		vim.keymap.set('n', '<leader>ds', dap.status)
		vim.keymap.set('n', '<leader>dll', dap.repl.toggle)
		vim.keymap.set('n', '<leader>dn', dap.step_over)
		vim.keymap.set('n', '<leader>di', dap.step_into)
		vim.keymap.set('n', '<leader>do', dap.step_out)
		vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint)
		vim.keymap.set('n', '<leader>dlb', dap.list_breakpoints)
		vim.keymap.set('n', '<leader>dlc', dap.clear_breakpoints)
		vim.keymap.set('n', '<leader>dh', function()
			dap_widgets.hover()
		end)
		-- vim.keymap.set('n', '<leader>d')
	end,
}
