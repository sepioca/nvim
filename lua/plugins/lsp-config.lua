return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "terraformls", "yamlls", "clangd", "omnisharp", "prismals", "postgres_lsp" },
				-- Disable automatic_enable - we manually enable servers via vim.lsp.enable()
				-- This prevents mason-lspconfig from auto-starting jdtls (handled by nvim-jdtls)
				automatic_enable = false,
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			notification = {
				window = {
					winblend = 0,
				},
			},
			progress = {
				suppress_on_insert = true,
				ignore_done_already = true,
				ignore_empty_message = true,
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- LSP servers configuration
			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = { callSnippet = "Replace" },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("ts_ls", {
				capabilities = capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})

			vim.lsp.config("terraformls", { capabilities = capabilities })

			vim.lsp.config("yamlls", {
				capabilities = capabilities,
				settings = {
					yaml = {
						schemas = {
							["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose*.yml",
						},
					},
				},
			})

			vim.lsp.config("postgres_lsp", {
				capabilities = capabilities,
				filetypes = { "sql" },
				root_markers = { "postgres-language-server.jsonc" },
			})

			vim.lsp.config("clangd", {
				capabilities = capabilities,
				cmd = { "clangd", "--background-index", "--clang-tidy" },
			})

			vim.lsp.config("gdscript", {
				capabilities = capabilities,
				-- Godot editor runs LSP on port 6005
				cmd = { "ncat", "localhost", "6005" },
			})

			vim.lsp.config("omnisharp", {
				capabilities = capabilities,
				cmd = { "OmniSharp", "--languageserver" },
				filetypes = { "cs" },
			})

			vim.lsp.config("prismals", {
				capabilities = capabilities,
			})

			-- Enable servers
			vim.lsp.enable("lua_ls")
			vim.lsp.enable("ts_ls")
			vim.lsp.enable("terraformls")
			vim.lsp.enable("yamlls")
			vim.lsp.enable("postgres_lsp")
			vim.lsp.enable("clangd")
			vim.lsp.enable("gdscript")
			vim.lsp.enable("omnisharp")
			vim.lsp.enable("prismals")

			-- LspAttach autocommand for keymaps
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					local builtin = require("telescope.builtin")
					map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
					map("gr", builtin.lsp_references, "[G]oto [R]eferences")
					map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
					map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<leader>lr", function()
						vim.lsp.stop_client(vim.lsp.get_clients({ bufnr = event.buf }))
						vim.cmd.edit()
					end, "[L]sp [R]estart")

					-- Highlight references on CursorHold
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
						local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})
					end

					-- Toggle inlay hints
					if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})
		end,
	},
}
