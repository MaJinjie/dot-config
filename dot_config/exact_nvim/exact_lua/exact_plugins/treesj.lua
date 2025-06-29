return {
	"Wansmer/treesj",
	lazy = true,
	cmd = "TSJToggle",
	opts = {
		use_default_keymaps = false,
		max_join_length = 160,
	},
	keys = { { "<leader>j", "<cmd>TSJToggle<cr>", desc = "Splitting/Joining blocks of code" } },
}
