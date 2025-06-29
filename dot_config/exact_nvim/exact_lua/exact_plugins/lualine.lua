return {
	"nvim-lualine/lualine.nvim",
	lazy = true,
	event = "LazyDash",
	opts = {
		options = {
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {},
			lualine_c = {
				"branch",
				{
					"diagnostics",
					symbols = {
						error = User.config.icons.diagnostics.error,
						warn = User.config.icons.diagnostics.warn,
						info = User.config.icons.diagnostics.info,
						hint = User.config.icons.diagnostics.hint,
					},
				},
			},
			lualine_x = {
        -- stylua: ignore
        {
          function() return require("noice").api.status.mode.get() end,
          cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          color = function() return { fg = Snacks.util.color("Constant") } end,
        },
				"lsp_status",
				"filetype",
			},
			lualine_y = {},
			lualine_z = { "progress" },
		},
		extensions = { "aerial", "lazy", "man", "neo-tree", "quickfix", "trouble" },
	},
}
