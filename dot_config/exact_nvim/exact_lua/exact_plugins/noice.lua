-- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
return {
	"folke/noice.nvim",
	lazy = true,
	event = "VeryLazy",
	opts = {
		cmdline = {
			format = {
				help = false,
				lua = false,
				filter = false,
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
			signature = { enabled = false },
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
		},
	},
  -- stylua: ignore
	keys = {
		{ "<C-CR>", function() require("noice").redirect(vim.fn.getcmdline()) end, desc = "Redirect Cmdline", mode = "c" },
		{ "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
		{ "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
		{ "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
		{ "<leader>nd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
		{ "<leader>sN", function() require("noice").cmd("pick") end, desc = "Notification History (Noice)" },
		{ "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, desc = "Scroll Forward", silent = true, expr = true },
		{ "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, desc = "Scroll Backward", silent = true, expr = true },
	},
}
