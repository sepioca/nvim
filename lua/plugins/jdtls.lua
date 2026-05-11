return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		local jdtls = require("jdtls")
		local mason_path = vim.fn.stdpath("data") .. "/mason/packages"
		local debug_jar = mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.2.jar"

		-- Verify jar exists
		if vim.fn.filereadable(debug_jar) == 0 then
			vim.notify("Debug jar not found: " .. debug_jar, vim.log.levels.ERROR)
			return
		end

		local config = {
			cmd = {
				vim.fn.stdpath("data") .. "/mason/bin/jdtls",
				"--java-executable", "/usr/lib/jvm/java-21-openjdk/bin/java",
				"-data", vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
			},
			root_dir = require("jdtls.setup").find_root({ ".git", "gradlew", "pom.xml", "build.gradle" }),
			init_options = {
				bundles = { debug_jar },
			},
			on_attach = function(client, bufnr)
				-- Check if debug extension loaded
				local caps = client.server_capabilities or {}
				vim.notify("jdtls attached, setting up DAP", vim.log.levels.INFO)

				require("jdtls").setup_dap({ hotcodereplace = "auto" })

				vim.defer_fn(function()
					require("jdtls.dap").setup_dap_main_class_configs({ verbose = true })
				end, 3000)
			end,
		}

		jdtls.start_or_attach(config)
	end,
}
