return {
	"mfussenegger/nvim-dap",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"rcarriga/nvim-dap-ui",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		dapui.setup()

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapBreakpointCondition",
			{ text = "◐", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
		)
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
		vim.fn.sign_define(
			"DapStopped",
			{ text = "→", texthl = "DiagnosticOk", linehl = "DapStoppedLine", numhl = "" }
		)
		vim.fn.sign_define(
			"DapBreakpointRejected",
			{ text = "✗", texthl = "DiagnosticError", linehl = "", numhl = "" }
		)

		-- Java adapter is handled by nvim-jdtls via jdtls.setup_dap()
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-dap",
			name = "lldb",
		}

		dap.adapters.godot = {
			type = "server",
			host = "127.0.0.1",
			port = 6006,
		}

		dap.adapters.coreclr = {
			type = "executable",
			command = "netcoredbg",
			args = { "--interpreter=vscode" },
		}

		dap.configurations.cs = {
			{
				type = "coreclr",
				name = "Launch",
				request = "launch",
				program = function()
					return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
				end,
			},
		}

		dap.configurations.gdscript = {
			{
				type = "godot",
				request = "launch",
				name = "Launch scene",
				project = "${workspaceFolder}",
				launch_scene = true,
			},
		}

		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return coroutine.create(function(coro)
						local pickers = require("telescope.pickers")
						local finders = require("telescope.finders")
						local conf = require("telescope.config").values
						local actions = require("telescope.actions")
						local action_state = require("telescope.actions.state")

						pickers
							.new({}, {
								prompt_title = "Select Executable",
								finder = finders.new_oneshot_job({ "find", ".", "-type", "f", "-executable" }, {}),
								sorter = conf.generic_sorter({}),
								attach_mappings = function(buffer_number)
									actions.select_default:replace(function()
										actions.close(buffer_number)
										coroutine.resume(coro, action_state.get_selected_entry()[1])
									end)
									return true
								end,
							})
							:find()
					end)
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = true,
				args = {},
			},
		}

		dap.configurations.c = dap.configurations.cpp
		dap.configurations.rust = dap.configurations.cpp

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Step out" })
		vim.keymap.set("n", "<leader>dq", function()
			dap.terminate()
			dapui.close()
		end, { desc = "Terminate debugger" })
		vim.keymap.set("n", "<leader>du", function()
			dapui.toggle()
		end, { desc = "Toggle DAP UI" })
		vim.keymap.set("n", "<leader>ds", function()
			dapui.float_element("scopes", { enter = true })
		end, { desc = "Show scopes" })
		vim.keymap.set("n", "<leader>dw", function()
			dapui.float_element("watches", { enter = true })
		end, { desc = "Show watches" })
		vim.keymap.set("n", "<leader>db", function()
			dapui.float_element("breakpoints", { enter = true })
		end, { desc = "Show breakpoints" })
		vim.keymap.set("n", "<leader>dk", function()
			dapui.float_element("stacks", { enter = true })
		end, { desc = "Show stacks" })
		vim.keymap.set("n", "<F6>", function()
			if vim.fn.filereadable(vim.fn.getcwd() .. "/project.godot") == 0 then
				print("Not a Godot project")
				return
			end
			require("telescope.builtin").find_files({
				prompt_title = "Select Scene",
				search_dirs = { vim.fn.getcwd() },
				find_command = { "find", ".", "-type", "d", "-name", "addons", "-prune", "-o", "-name", "*.tscn", "-type", "f", "-print" },
				attach_mappings = function(_, map)
					map("i", "<CR>", function(prompt_bufnr)
						local entry = require("telescope.actions.state").get_selected_entry()
						require("telescope.actions").close(prompt_bufnr)
						local scene = entry.path or entry[1]
						local cmd = "/opt/godot/godot --path " .. vim.fn.getcwd() .. " " .. scene
						vim.cmd("botright split | terminal " .. cmd)
					end)
					return true
				end,
			})
		end, { desc = "Run selected scene in terminal" })
	end,
}
