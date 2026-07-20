return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		local function start_jdtls()
			-- For multi-module projects, prioritize settings.gradle (root) over build.gradle (subproject)
			local root_dir = require("jdtls.setup").find_root({ "settings.gradle", "pom.xml" })
				or require("jdtls.setup").find_root({ "build.gradle", ".git" })
			if not root_dir then return end

			local data_dir = vim.fn.stdpath("data")
			local project_name = vim.fn.fnamemodify(root_dir, ":t")

			require("jdtls").start_or_attach({
				cmd = {
					data_dir .. "/mason/bin/jdtls",
					"--java-executable", "/usr/lib/jvm/java-21-openjdk/bin/java",
					"-data", data_dir .. "/jdtls-workspace/" .. project_name,
				},
				root_dir = root_dir,
				settings = {
					java = {
						codeGeneration = {
							generateComments = false,
							useBlocks = true,
							methodBody = "return_default",
						},
					},
				},
				init_options = {
					bundles = { vim.fn.glob(data_dir .. "/mason/packages/java-debug-adapter/extension/server/*.jar") },
				},
				on_attach = function(client)
					if not client._dap_configured then
						client._dap_configured = true
						require("jdtls").setup_dap({ hotcodereplace = "auto" })
					end
				end,
			})
		end

		vim.api.nvim_create_autocmd("FileType", { pattern = "java", callback = start_jdtls })
		start_jdtls()
	end,
}
