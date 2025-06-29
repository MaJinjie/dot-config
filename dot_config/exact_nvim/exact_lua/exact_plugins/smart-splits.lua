return {
	"mrjones2014/smart-splits.nvim",
	enabled = vim.env.TMUX ~= nil,
	opts = {
		ignored_filetypes = { "neo-tree" },
	},
  -- stylua: ignore
  keys = {
    { "<C-S-h>", function() require("smart-splits").resize_left() end, desc = "Resize split left" },
    { "<C-S-j>", function() require("smart-splits").resize_down() end, desc = "Resize split down" },
    { "<C-S-k>", function() require("smart-splits").resize_up() end, desc = "Resize split up" },
    { "<C-S-l>", function() require("smart-splits").resize_right() end, desc = "Resize split right" },

    { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" },
    { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" },
    { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" },
    { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" },
    { "<C-\\>", function() require("smart-splits").move_cursor_previous() end, desc = "Move to previous split" },

    { "<C-A-h>", function() require("smart-splits").swap_buf_left() end, desc = "Swap buffer left" },
    { "<C-A-j>", function() require("smart-splits").swap_buf_down() end, desc = "Swap buffer down" },
    { "<C-A-k>", function() require("smart-splits").swap_buf_up() end, desc = "Swap buffer up" },
    { "<C-A-l>", function() require("smart-splits").swap_buf_right() end, desc = "Swap buffer right" },
  }
,
}
