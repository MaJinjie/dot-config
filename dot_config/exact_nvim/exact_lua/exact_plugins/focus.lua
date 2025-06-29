return {
	"nvim-focus/focus.nvim",
	opts = {
		ignore_buftypes = { "prompt", "nofile" },
		ignore_filetypes = { "neo-tree" },
		ui = {
			number = false, -- Display line numbers in the focussed window only
			relativenumber = false, -- Display relative line numbers in the focussed window only
			hybridnumber = false, -- Display hybrid line numbers in the focussed window only
			absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

			cursorline = false, -- Display a cursorline in the focussed window only
			cursorcolumn = false, -- Display cursorcolumn in the focussed window only
			colorcolumn = {
				enable = true, -- Display colorcolumn in the foccused window only
				list = "+1", -- Set the comma-saperated list for the colorcolumn
			},
			signcolumn = false, -- Display signcolumn in the focussed window only
			winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
		},
	},
	config = function(_, opts)
		require("focus").setup(opts)

		local augroup = vim.api.nvim_create_augroup("plugins.focus", {})
		vim.api.nvim_del_augroup_by_name("user.resize")
		vim.api.nvim_create_autocmd({ "VimResized" }, {
			group = augroup,
			callback = function()
				if vim.g.focus_disable then
					vim.cmd("wincmd =")
				else
					require("focus").resize()
				end
			end,
		})
		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(opts.ignore_buftypes, vim.bo.buftype) then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
			desc = "Disable focus autoresize for BufType",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			callback = function(_)
				if vim.tbl_contains(opts.ignore_filetypes, vim.bo.filetype) then
					vim.b.focus_disable = true
				else
					vim.b.focus_disable = false
				end
			end,
			desc = "Disable focus autoresize for FileType",
		})
	end,
	init = function()
		User.util.on_load("snacks.nvim", function()
			Snacks.toggle({
				name = "Focus",
				get = function()
					return not vim.g.focus_disable
				end,
				set = function(state)
					local focus = require("focus")
					vim.print(state, vim.g.focus_disable)
					if state then
						vim.g.focus_disable = false
						focus.resize()
					else
						vim.g.focus_disable = true
					end
				end,
			}):map("<leader>uF")
		end)
	end,
}
