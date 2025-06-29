-- WARN: NIXOS don't use.

local M = {}

function M.get_package_names()
	local names = {}

	vim.list_extend(names, vim.tbl_keys(User.util.get_plugin_opts("nvim-lspconfig")))

	vim.list_extend(names, vim.tbl_keys(User.util.get_plugin_opts("nvim-dap", "adapters")))

	for lang, linters in pairs(User.util.get_plugin_opts("nvim-lint", "linters_by_ft")) do
		if type(lang) == "string" and type(linters) == "table" then
      -- stylua: ignore
			vim.list_extend(names, vim.tbl_filter(function(value) return type(value) == "string" end, linters))
		end
	end

	for lang, formatters in pairs(User.util.get_plugin_opts("conform.nvim", "formatters_by_ft")) do
		if type(lang) == "string" and type(formatters) == "table" then
      -- stylua: ignore
			vim.list_extend(names, vim.tbl_filter(function(value) return type(value) == "string" end, formatters))
		end
	end

	return names
end

function M.get_package_aliases()
	local aliases = {
		require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package,
		require("mason-nvim-dap.mappings.source").nvim_dap_to_package,
		require("mason-nvim-lint.mapping").nvimlint_to_package,
		require("mason-conform.mapping").conform_to_package,
	}

	local ret = {}
	local t = ret
	for _, alias in ipairs(aliases) do
		setmetatable(t, { __index = alias })
		t = getmetatable(t).__index
	end

	return ret
end

return {
	{
		"mason-org/mason.nvim",
		lazy = true,
		event = "LazyFile",
		cmd = "Mason",
		opts = {
			ensure_installed = {},
			ignore_install = { "*", "_" },
		},
		config = function()
			require("mason").setup()
			require("mason-registry"):on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)
		end,
		init = function()
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				local mr = require("mason-registry")

        -- stylua: ignore
				mr.refresh(function()
					local ensure_installed = vim.list_extend( M.get_package_names(), User.util.get_plugin_opts("mason.nvim", "ensure_installed"))
					local ignore_install = User.util.get_plugin_opts("mason.nvim", "ensure_installed")
					local aliases = M.get_package_aliases()

					for _, name in ipairs(ensure_installed) do
						if not vim.list_contains(ignore_install, name) then
							local pkg = mr.get_package(aliases[name] or name)
							if not pkg:is_installed() then
								pkg:install()
							end
						end
					end
				end)
			end, { desc = "Install All Packages Using Mason" })
		end,
	},
	{ "mason-org/mason-lspconfig.nvim", lazy = true },
	{ "jay-babu/mason-nvim-dap.nvim", lazy = true },
	{ "rshkarin/mason-nvim-lint", lazy = true },
	{ "zapling/mason-conform.nvim", lazy = true },
}
