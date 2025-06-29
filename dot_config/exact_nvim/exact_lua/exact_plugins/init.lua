-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local augroup = vim.api.nvim_create_augroup("user.lazy", { clear = true })
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufWritePre" }, {
	group = augroup,
	callback = function()
		vim.api.nvim_exec_autocmds("User", { pattern = "LazyFile" })
	end,
	once = true,
})
vim.api.nvim_create_autocmd("VimEnter", {
	group = augroup,
	callback = function()
		local trigger = function()
			vim.api.nvim_exec_autocmds("User", { pattern = "LazyDash" })
		end
		if vim.fn.argc(-1) == 0 then
			vim.api.nvim_create_autocmd("User", { pattern = "LazyFile", callback = trigger, once = true })
		else
			trigger()
		end
	end,
	once = true,
})

require("lazy.core.handler.event").mappings["LazyFile"] = { id = "LazyFile", event = "User", pattern = "LazyFile" }
require("lazy.core.handler.event").mappings["LazyDash"] = { id = "LazyDash", event = "User", pattern = "LazyDash" }

require("lazy").setup({
	spec = {
		-- colorscheme
		{ import = "plugins.tokyonight" },

		-- Icons
		{ import = "plugins.web-devicons" },

		-- statusline
		{ import = "plugins.lualine" },

		-- winbar
		{ import = "plugins.heirline" },

		-- tabline
		{ import = "plugins.bufferline" },

		-- outline
		{ import = "plugins.aerial" },

		-- netrw
		{ import = "plugins.neo-tree" },

		-- statuscolumn
		-- indent guides
		-- scopes
		-- lsp references
		-- image support
		-- dashboard
		-- better vim.input, vim.notify
		{ import = "plugins.snacks" },

		-- syntax highlight
		{ import = "plugins.treesitter" },

		-- session management
		{ import = "plugins.persistence" },

		-- git signs and git actions
		{ import = "plugins.gitsigns" },

		-- autopairs brackets
		{ import = "plugins.autopairs" },

		-- fast surround
		{ import = "plugins.surround" },

		-- enhance keybindings
		{ import = "plugins.which-key" },

		-- better ui for messages, cmdline and popupmenu
		{ import = "plugins.noice" },

		-- TODO etc comments
		{ import = "plugins.todo-comments" },

		-- fast jump
		-- enhance f/F t/T
		{ import = "plugins.leap" },

		-- comments
		{ import = "plugins.ts-context-commentstring" },

		-- integration yazi
		{ import = "plugins.yazi" },

		-- completion
		{ import = "plugins.blink-cmp" },

		-- multi cursor
		{ import = "plugins.visual-multi" },

		-- language servser protocol
		{ import = "plugins.lspconfig" },

		-- formatter
		{ import = "plugins.conform" },

		-- better edit neovim configuation
		{ import = "plugins.lazydev" },

		-- replace
		{ import = "plugins.rip-substitute" },
		{ import = "plugins.grug-far" },

		-- enhance window
		{ import = "plugins.focus" },

		-- enhance quickfix
		{ import = "plugins.bqf" },

		-- enhance tabpages
		-- { import = "plugins.scope" },

		-- Enhance yank
		{ import = "plugins.yanky" },

		-- Enhance help
		{ import = "plugins.helpview" },

		-- Enhance <c-a> <c-x> g<c-a> g<c-x>
		{ import = "plugins.dial" },

		-- Enhance move
		{ import = "plugins.quick-scope" },

		-- Hightlight colors
		{ import = "plugins.highlight-colors" },

		-- Switch inputMethod
		-- { import = "plugins.im-select" },

		-- Split or Join
		{ import = "plugins.treesj" },

		-- integration git
		{ import = "plugins.neogit" },

		-- integration tmux
		{ import = "plugins.tmux" },

		-- Debug Adapter Protocol
		{ import = "plugins.dap" },

		-- Test within Neovim
		{ import = "plugins.neotest" },

		-- Languages Configuations
		{ import = "plugins.yaml" },
		{ import = "plugins.json" },
		{ import = "plugins.rust" },
		{ import = "plugins.markdown" },

		{ import = "plugins.libraries" },
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"netrwPlugin", -- 避免与neo-tree冲突
			},
		},
	},
})
