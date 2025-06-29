return {
	"gbprod/yanky.nvim",
	lazy = true,
	cmd = { "YankyRingHistory", "YankyClearHistory" },

  -- stylua: ignore
	keys = {
		{ "y", "<Plug>(YankyYank)", mode = {"n", "x"}, desc = "Yank Text" },
    { "Y", "y$", desc = "Yank Text until the end of line" },

		{ "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor" },
		{ "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor" },
		{ "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put Text After Cursor And Move Cursor After Cursor" },
		{ "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put Text Before Cursor And Move Cursor Before Cursor" },

		{ "[p", "<Plug>(YankyPreviousEntry)", desc = "Cycle Previous Yank History" },
		{ "]p", "<Plug>(YankyNextEntry)", desc = "Cycle Next Yank History" },
		{ "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
		{ "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
		{ "zp", "<Plug>(YankyPutAfterFilter)", desc = "Put After Applying a Filter" },
		{ "zP", "<Plug>(YankyPutBeforeFilter)", desc = "Put Before Applying a Filter" },
	},
	opts = { highlight = { timer = 200 } },
}
