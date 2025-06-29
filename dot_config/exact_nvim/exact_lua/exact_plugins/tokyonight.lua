return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	---@type tokyonight.Config|{}
	opts = {
		style = "night",
		dim_inactive = true,
		lualine_bold = true,
		--- You can override specific highlights to use other groups or a hex color
		--- function will be called with a Highlights and ColorScheme table
		---@param highlights tokyonight.Highlights
		---@param colors ColorScheme
		on_highlights = function(highlights, colors)
			highlights.QuickScopePrimary = { underline = true }
			highlights.QuickScopeSecondary = { underline = true }

			highlights.Comment = { fg = colors.comment }
		end,
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd("colorscheme tokyonight")
	end,
}
