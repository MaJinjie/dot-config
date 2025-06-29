return {
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		lazy = true,
		event = { "InsertEnter", "CmdlineEnter" },
		opts_extend = { "sources.default" },
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			fuzzy = { implementation = "rust" },
			appearance = { kind_icons = User.config.icons.kinds },
			keymap = {
				preset = "none",
				["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "cancel", "fallback" },
				["<C-y>"] = { "select_and_accept" },

				["<Tab>"] = { "snippet_forward", "fallback" },
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<C-j>"] = { "select_next", "fallback_to_mappings" },
				["<C-k>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<Down>"] = { "select_next", "fallback" },
				["<Up>"] = { "select_prev", "fallback" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
			},
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 2 } },
						components = {
							-- NOTE: https://github.com/brenoprata10/nvim-highlight-colors?tab=readme-ov-file#blinkcmp-integration
							kind_icon = {
								text = function(ctx)
									-- default kind icon
									local icon = ctx.kind_icon
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr ~= "" then
											icon = color_item.abbr
										end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									-- default highlight group
									local highlight = "BlinkCmpKind" .. ctx.kind
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				ghost_text = { enabled = true },
			},
			signature = { enabled = true },
			cmdline = {
				keymap = {
					preset = "none",
					["<C-Space>"] = { "show", "hide" },
					["<Tab>"] = { "show_and_insert", "select_next" },
					["<S-Tab>"] = { "show_and_insert", "select_prev" },

					["<C-j>"] = { "select_next" },
					["<C-k>"] = { "select_prev" },
					-- ["<C-n>"] = { "select_next" },
					-- ["<C-p>"] = { "select_prev" },
					["<Down>"] = { "select_next", "fallback" },
					["<Up>"] = { "select_prev", "fallback" },

					["<C-y>"] = { "select_and_accept" },
					["<C-e>"] = { "cancel" },
				},
				completion = {
					list = { selection = { preselect = false } },
					menu = {
						auto_show = true,
						draw = { columns = { { "label" } } },
					},
					ghost_text = { enabled = true },
				},
			},
		},
	},
	{ "xzbdmw/colorful-menu.nvim", lazy = true },
}
