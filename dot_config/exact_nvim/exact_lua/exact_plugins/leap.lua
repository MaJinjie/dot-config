return {
	-- leap.nvim allows you to reach any target in a very fast, uniform way,
	-- and minimizes the required focus level while executing a jump.
	{
		"ggandor/leap.nvim",
		dependencies = "tpope/vim-repeat",
		lazy = true,
		event = "LazyFile",
		opts = {
			equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" },
			preview_filter = function(ch0, ch1, ch2)
				return not (ch1:match("%s") or ch0:match("%w") and ch1:match("%w") and ch2:match("%w"))
			end,
		},
    -- stylua: ignore
    keys = {
      { "s",     "<Plug>(leap)",                                     mode = "n",               desc = "Jump to the current window" },
      { "S",     function() require("leap.remote").action() end,     mode = "n",               desc = "Leap Remote" },
      { "s",     "<Plug>(leap-forward)",                             mode = "x",               desc = "Jump to forward" },
      { "S",     "<Plug>(leap-backward)",                            mode = "x",               desc = "Jump to backward" },
      { "g<cr>", function() require("leap.treesitter").select() end, mode = { "n", "v", "o" }, desc = "Select Treesitter Node" },
    },
		config = function(_, opts)
			local leap = require("leap")
			for k, v in pairs(opts) do
				leap.opts[k] = v
			end
		end,
	},
	{
		"ggandor/flit.nvim",
		lazy = true,
		event = "LazyFile",
		opts = {
			multiline = false,
		},
	},
}
