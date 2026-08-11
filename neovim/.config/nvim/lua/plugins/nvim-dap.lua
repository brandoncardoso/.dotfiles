return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			"mason-org/mason.nvim",
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio", -- required by nvim-dap-ui
		},
		config = function()
			local dap = require('dap')
			local dapui = require('dapui')

			dapui.setup()

			dap.adapters.coreclr = {
				type = 'executable',
				command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
				args = { '--interpreter=vscode' },
			}

			dap.configurations.cs = {
				{
					type = "coreclr",
					name = "launch - netcoredbg",
					request = "launch",
					program = function()
						return vim.fn.input(
							"Path to dll: ",
							vim.fn.getcwd() .. "/bin/Debug",
							"file"
						)
					end,
				},
				{
					type = "coreclr",
					name = "attach - test host",
					request = "attach",
					processId = function()
						return require("dap.utils").pick_process({ filter = "testhost" })
					end,
				},
			}

			-- Auto open/close dap-ui
			dap.listeners.before.attach.dapui_config = dapui.open
			dap.listeners.before.launch.dapui_config = dapui.open
			dap.listeners.before.event_terminated.dapui_config = dapui.close
			dap.listeners.before.event_exited.dapui_config = dapui.close

			vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP step over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP step into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP step out" })
			vim.keymap.set("n", "<Leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>dr", dap.repl.open, { desc = "Open REPL" })
		end,
	}
}
