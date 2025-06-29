return {
	"brenoprata10/nvim-highlight-colors",
	lazy = true,
	event = "LazyFile",
	opts = { enabled_named_colors = false },
	init = function()
		User.util.on_load("snacks.nvim", function()
			local hc = User.util.lazy_require("nvim-highlight-colors")
			Snacks.toggle({
				name = "Highlight Colors",
				get = function()
					return hc.is_active()
				end,
				set = function(state)
					if state then
						hc.turnOn()
					else
						hc.turnOff()
					end
				end,
			}):map("<leader>uH")
		end)
	end,
}
