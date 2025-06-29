return {
	"Bekaboo/dropbar.nvim",
	dependencies = { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	enabled = false,
	lazy = true,
	event = "LazyDash",
	opts = {
		bar = {
			update_debounce = 75,
		},
		sources = {
			path = {
				max_depth = 1,
				preview = false,
			},
			treesitter = {
				max_depth = 6,
			},
			lsp = {
				max_depth = 6,
			},
		},
	},
  -- stylua: ignore
  keys = {
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick symbols in winbar" },
    { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
    { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
  },
}
