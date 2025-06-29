return {
	{
		"saecki/crates.nvim",
		lazy = true,
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		lazy = true,
		ft = "rust",
		opts = {
			server = {
        -- stylua: ignore
				on_attach = function(_, bufnr)
					vim.keymap.set("n", "<leader>cR", function() vim.cmd.RustLsp("codeAction") end, { desc = "Code Action", buffer = bufnr })
					vim.keymap.set("n", "<leader>dr", function() vim.cmd.RustLsp("debuggables") end, { desc = "Rust Debuggables", buffer = bufnr })
				end,
				default_settings = {
					-- rust-analyzer language server configuration
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
							loadOutDirsFromCheck = true,
							buildScripts = {
								enable = true,
							},
						},
						-- disable clippy lints for Rust if using rust-analyzer
						checkOnSave = true,
						-- disable diagnostics if using rust-analyzer
						diagnostics = {
							enable = true,
						},
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
						files = {
							excludeDirs = {
								".direnv",
								".git",
								".github",
								".gitlab",
								"target",
							},
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim or {}, opts)
		end,
	},
	{
		"cordx56/rustowl",
		lazy = true,
		ft = "rust",
		opts = {
			client = {
        -- stylua: ignore
				on_attach = function(_, buffer)
					vim.keymap.set("n", "<leader>o", function() require("rustowl").toggle(buffer) end, { buffer = buffer, desc = "Toggle RustOwl" })
				end,
			},
		},
	},
}
