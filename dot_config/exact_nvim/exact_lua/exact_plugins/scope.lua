return {
	"tiagovla/scope.nvim",
	lazy = true,
	event = "LazyDash",
	opts = {},
	init = function()
		local augroup = vim.api.nvim_create_augroup("scope.persistence", { clear = true })
		User.util.on_load("persistence.nvim", function()
			vim.api.nvim_create_autocmd("User", {
				group = augroup,
				pattern = "PersistenceSavePre",
				command = "ScopeSaveState",
			})
			vim.api.nvim_create_autocmd("User", {
				group = augroup,
				pattern = "PersistenceLoadPre",
				command = "ScopeLoadState",
			})
		end)
	end,
}
