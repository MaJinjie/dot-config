return {
	{
		"christoomey/vim-tmux-navigator",
		lazy = true,
		init = function()
			vim.g.tmux_navigator_no_mappings = 1

			vim.g.tmux_navigator_disable_when_zoomed = 0
			vim.g.tmux_navigator_preserve_zoom = 1
			vim.g.tmux_navigator_no_wrap = 1
		end,
    -- stylua: ignore
		keys = {
			{ "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Move to left split" },
			{ "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Move to below split" },
			{ "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Move to above split" },
			{ "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Move to right split" },
			{ "<C-/>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Move to previous split" },
		},
	},
	{
		"aserowy/tmux.nvim",
		lazy = true,
		opts = {
			navigation = { cycle_navigation = false, enable_default_keybindings = false, persist_zoom = true },
			resize = { enable_default_keybindings = false, resize_step_x = 5, resize_step_y = 5 },
			swap = { cycle_navigation = false, enable_default_keybindings = false },
		},
    -- stylua: ignore
		keys = {
      { "<C-S-h>", function() require("tmux").resize_left() end, desc = "Resize split left" },
      { "<C-S-j>", function() require("tmux").resize_bottom() end, desc = "Resize split down" },
      { "<C-S-k>", function() require("tmux").resize_top() end, desc = "Resize split up" },
      { "<C-S-l>", function() require("tmux").resize_right() end, desc = "Resize split right" },


      { "<C-A-h>", function() require("tmux").swap_left() end, desc = "Swap buffer left" },
      { "<C-A-j>", function() require("tmux").swap_bottom() end, desc = "Swap buffer down" },
      { "<C-A-k>", function() require("tmux").swap_top() end, desc = "Swap buffer up" },
      { "<C-A-l>", function() require("tmux").swap_right() end, desc = "Swap buffer right" },
    },
	},
}
