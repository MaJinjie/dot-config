return {
	"MagicDuck/grug-far.nvim",
	lazy = true,
	cmd = "GrugFar",
	opts = {},
	keys = {
		{
			"<leader>srr",
			function()
				require("grug-far").open({ transient = true })
			end,
			mode = { "n", "v" },
			desc = "Search and Replace",
		},
	},
}
