return {
	"stevearc/conform.nvim",
	lazy = true,
	event = "LazyFile",
	---@type conform.setupOpts
	opts = {
		formatters_by_ft = {
			lua = { "stylua", lsp_format = "fallback" },
			toml = { "taplo" },
			rust = { "rustfmt", lsp_format = "fallback" },
			nix = { "nixfmt" },
			json = { "jq" },
		},
		format_on_save = function(bufnr)
			return vim.g.autoformat and { bufnr = bufnr } or nil
		end,
	},
	init = function()
		vim.opt.formatexpr = "v:lua.require'conform'.formatexpr()"

		User.util.on_load("snacks.nvim", function()
			Snacks.toggle({
				name = "AutoFormat",
				get = function()
					return vim.g.autoformat
				end,
				set = function(state)
					vim.g.autoformat = state
				end,
			}):map("<leader>uf")
		end)
	end,
}
