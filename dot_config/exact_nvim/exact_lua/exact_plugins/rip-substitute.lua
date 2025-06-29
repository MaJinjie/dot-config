return {
	"chrisgrieser/nvim-rip-substitute",
	lazy = true,
	cmd = "RipSubstitute",
	opts = {
		keymaps = { -- normal mode (if not stated otherwise)
			prevSubstitutionInHistory = "<c-p>",
			nextSubstitutionInHistory = "<c-n>",
		},
	},
	keys = {
		{
			"<leader>sR",
			function()
				require("rip-substitute").sub()
			end,
			mode = { "n", "x" },
			desc = "rip substitute",
		},
	},
}
