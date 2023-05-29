function setup()
	local lspconfig = require("lspconfig")

	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

	local prettier = {
		formatCommand = "node_modules/.bin/prettier --stdin-filepath ${INPUT}",
		formatStdin = true,
	}

	local eslint = {
		lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
		lintIgnoreExitCode = true,
		lintStdin = true,
		lintFormats = { "%f:%l:%c: %m" },
		formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
		formatStdin = true,
	}

	local efm_langserver_args = {}

	table.insert(efm_langserver_args, prettier)
	table.insert(efm_langserver_args, eslint)

	local format_async = function(err, result, ctx)
		if err ~= nil or result == nil then
			return
		end

		local bufnr = ctx.bufnr
		if not vim.api.nvim_buf_get_option(bufnr, "modified") then
			local view = vim.fn.winsaveview()
			vim.lsp.util.apply_text_edits(result, bufnr)
			vim.fn.winrestview(view)
			if bufnr == vim.api.nvim_get_current_buf() then
				vim.api.nvim_command("noautocmd :update")
			end
		end
	end

	vim.lsp.handlers["textDocument/formatting"] = format_async

	local function filter(arr, fn)
		if type(arr) ~= "table" then
			return arr
		end

		local filtered = {}
		for k, v in pairs(arr) do
			if fn(v, k, arr) then
				table.insert(filtered, v)
			end
		end

		return filtered
	end

	local function filterReactDTS(value)
		return string.match(value.targetUri, "react/index.d.ts") == nil
	end

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(client, bufnr)
		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end

		local function buf_set_option(...)
			vim.api.nvim_buf_set_option(bufnr, ...)
		end

		--Enable completion triggered by <c-x><c-o>
		buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		local opts = { noremap = true, silent = true }

		-- See `:help vim.lsp.*` for documentation on any of the below functions
		buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		buf_set_keymap("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		buf_set_keymap("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		buf_set_keymap("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		buf_set_keymap("n", "U", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		buf_set_keymap("n", "<leader>ls", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
		buf_set_keymap("n", "<leader>lS", "<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", opts)
		buf_set_keymap("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		buf_set_keymap("n", "<leader>lA", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
		buf_set_keymap("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
		buf_set_keymap("n", "<c-t>", "<cmd>Telescope lsp_workspace_symbols<cr>", opts)

		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_exec(
				[[
         augroup LspAutocommands
             autocmd! * <buffer>
             autocmd BufWritePost <buffer> lua vim.lsp.buf.format()
         augroup END
         ]],
				true
			)
		end
	end

	-- Use a loop to conveniently call 'setup' on multiple servers and
	-- map buffer local keybindings when the language server attaches
	local servers = { "bashls", "cssls", "html", "solargraph", "vimls", "yamlls" }
	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			flags = {
				debounce_text_changes = 100,
			},
		})
	end

	lspconfig.tsserver.setup({
		capabilities = capabilities,
		filetypes = { "javascriptreact", "javascript", "typescript", "typescriptreact", "json" },
		handlers = {
			-- https://github.com/typescript-language-server/typescript-language-server/issues/216
			["textDocument/definition"] = function(err, result, method, ...)
				if vim.tbl_islist(result) and #result > 1 then
					local filtered_result = filter(result, filterReactDTS)
					return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
				end

				vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
			end,
		},
		init_options = {
			documentFormatting = false,
		},
		preferences = {
			importModuleSpecifierPreference = "project-relative",
		},
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			on_attach(client, bufnr)
		end,
		root_dir = lspconfig.util.root_pattern("tsconfig.json"),
	})

	lspconfig.jsonls.setup({
		capabilities = capabilities,
		cmd = { "vscode-json-languageserver", "--stdio" },
		on_attach = function(client, bufnr)
			client.server_capabilities.documentFormattingProvider = false
			on_attach(client, bufnr)
		end,
		flags = {
			debounce_text_changes = 150,
		},
	})

	lspconfig.sqlls.setup({
		capabilities = capabilities,
		cmd = { "/usr/local/bin/sql-language-server", "up", "--method", "stdio" },
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})

	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		commands = {
			Format = {
				function()
					require("stylua-nvim").format_file()
				end,
			},
		},
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})

	lspconfig.rust_analyzer.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				assist = {
					importGranularity = "module",
					importPrefix = "by_self",
				},
				cargo = {
					loadOutDirsFromCheck = true,
				},
				checkOnSave = {
					command = "clippy",
				},
				procMacro = {
					enable = true,
				},
			},
		},
		flags = {
			debounce_text_changes = 150,
		},
	})

	vim.filetype.add({
		extension = {
			mdx = "mdx",
		},
	})

	lspconfig.efm.setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 100,
		},
		init_options = {
			documentFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		root_dir = lspconfig.util.root_pattern(".git/"),
		filetypes = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"markdown",
			"mdx",
			"prisma",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
			"yaml",
		},
		settings = {
			rootMarkers = { ".git/", ".prettierrc" },
			languages = {
				css = { prettier },
				html = { prettier },
				javascript = efm_langserver_args,
				javascriptreact = efm_langserver_args,
				json = { prettier },
				markdown = { prettier },
				mdx = { prettier },
				prisma = { prettier },
				typescript = efm_langserver_args,
				typescriptreact = efm_langserver_args,
				vue = efm_langserver_args,
				yaml = { prettier },
			},
		},
	})
end

return setup
