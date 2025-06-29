return {
	"unblevable/quick-scope",
	lazy = true,
	event = "LazyFile",
	init = function()
		vim.g.qs_enable = 1
		vim.g.qs_hi_priority = 100
		vim.g.qs_max_chars = 160
		-- vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }

		User.util.on_load("snacks.nvim", function()
			Snacks.toggle({
				name = "Quick Scope",
				get = function()
					return vim.g.qs_enable ~= 0
				end,
				set = function()
					vim.g.qs_enable = (vim.g.qs_enable + 1) % 2
				end,
			}):map("<leader>uq")
		end)
	end,
}
