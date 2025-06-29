-- which-key helps you remember key bindings by showing a popup
-- with the active keybindings of the command you started typing.
return {
	"folke/which-key.nvim",
	lazy = true,
	event = "VeryLazy",
	opts_extend = { "spec" },
	opts = {
		preset = "helix",
		defaults = {},
		spec = {
			{
				mode = { "n", "v" },
				{ "<leader><tab>", group = "tabs" },
				{ "<leader>c", group = "code" },
				{ "<leader>d", group = "debug" },
				{ "<leader>dp", group = "profiler" },
				{ "<leader>f", group = "find" },
				{ "<leader>s", group = "search" },
				{ "<leader>sr", group = "grug-far", icon = { icon = " ", color = "orange" } },
				{ "<leader>g", group = "git" },
				{ "<leader>gh", group = "hunks" },
				{ "<leader>n", group = "noice/notify" },
				{ "<leader>p", group = "persistence" },
				{ "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
				{ "<leader>t", group = "test" },
				{ "<leader>d", group = "debug" },
				-- { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
				{ "[", group = "prev" },
				{ "]", group = "next" },
				{ "g", group = "goto" },
				{ "z", group = "fold" },
				{
					"<leader>b",
					group = "buffer",
					expand = function()
						return require("which-key.extras").expand.buf()
					end,
				},
				{
					"<leader>w",
					group = "windows",
					proxy = "<c-w>",
					expand = function()
						return require("which-key.extras").expand.win()
					end,
				},
				-- better descriptions
				{ "gx", desc = "Open with system app" },
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Keymaps (which-key)",
		},
		{
			"<c-w>?",
			function()
				require("which-key").show({ keys = "<c-w>", loop = true })
			end,
			desc = "Window Hydra Mode (which-key)",
		},
	},
}
