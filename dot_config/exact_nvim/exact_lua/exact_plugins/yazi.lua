return {
	"mikavilpas/yazi.nvim",
	lazy = true,
	opts = {
		keymaps = {
			show_help = "<c-x>?",
			open_file_in_vertical_split = "<c->v",
			open_file_in_horizontal_split = "<c-x>sj",
			open_file_in_tab = "<c-x>t",
			grep_in_directory = "<c-x>g",
			replace_in_directory = "<c-x>r",
			cycle_open_buffers = "<c-x><tab>",
			copy_relative_path_to_selected_files = "<c-x>y",
			send_to_quickfix_list = "<c-x>q",
			change_working_directory = "<c-x>c",
			open_and_pick_window = "<c-x>o",
		},
	},
  -- stylua: ignore
  keys = {
    { "-", function() require("yazi").toggle() end,               desc = "Toggle Yazi" },
    { "<leader>e", function() require("yazi").yazi(nil, User.root()) end,  desc = "Open yazi (Cwd)" },
    { "<leader>E", function() require("yazi").yazi(nil, User.root.cwd()) end, desc = "Open Yazi (Root Dir)" },
  },
}
