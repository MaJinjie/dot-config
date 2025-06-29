-- This is what powers LazyVim's fancy-looking
-- tabs, which include filetype icons and close buttons.
return {
	"akinsho/bufferline.nvim",
	lazy = true,
	event = "LazyDash",
	opts = {
		options = {
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local severity = level == "error" and "error" or level == "warning" and "warn" or nil
				return severity and User.config.icons.diagnostics[severity] .. count or ""
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "center",
					separator = true,
				},
				{
					filetype = "snacks_layout_box",
				},
			},
			always_show_bufferline = false,
		},
	},
	keys = {
		{ "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },

		{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
		{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned/Non-Visual Buffers" },

		{ "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		{ "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
	},
	init = function()
		User.util.on_load("snacks.nvim", function()
			vim.keymap.set("n", "<leader>bx", Snacks.bufdelete.delete, { desc = "Delete Current Buffer" })
			vim.keymap.set("n", "<leader>bV", function()
				local tab_buflist = vim.fn.tabpagebuflist()
				return Snacks.bufdelete(function(buf)
					return not vim.list_contains(tab_buflist, buf)
				end, { desc = "Delete All Buffers But Visual" })
			end, { desc = "Delete Other Buffers" })
			vim.keymap.set("n", "<leader>bo", Snacks.bufdelete.other, { desc = "Delete Other Buffers" })
			vim.keymap.set("n", "<leader>ba", Snacks.bufdelete.all, { desc = "Delete All Buffers" })
		end)
	end,
}
