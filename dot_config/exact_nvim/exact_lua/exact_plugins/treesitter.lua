-- Treesitter is a new parser generator tool that we can
-- use in Neovim to power faster and more accurate
-- syntax highlighting.
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		event = "LazyFile",
		keys = { { "<C-Enter>", desc = "Treesitter Selection" } },
		---@module 'nvim-treesitter'
		---@type TSConfig|{}
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"css",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"json5",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"hyprlang",
				"nix",
				"just",
				"rust",
				"rasi",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-Enter>",
					node_incremental = "<Enter>",
					scope_incremental = "<C-Enter>",
					node_decremental = "<Bs>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					set_jumps = false,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
						["]o"] = "@block.inner",
					},
					goto_next_end = {
						["]F"] = "@function.outer",
						["]C"] = "@class.outer",
						["]A"] = "@parameter.outer",
						["]O"] = "@block.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
						["[o"] = "@block.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
						["[O"] = "@block.outer",
					},
				},
				swap = {
					enable = true,
					swap_next = {
						["]A"] = "@parameter.inner",
					},
					swap_previous = {
						["[A"] = "@parameter.inner",
					},
				},
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["aa"] = "@parameter.outer",
						["ia"] = "@parameter.inner",
						["ao"] = "@block.outer",
						["io"] = "@block.inner",
					},
					selection_modes = {
						["@function.outer"] = "V",
						["@class.outer"] = "V",
					},
				},
				endwise = { enable = true },
			},
		},
		main = "nvim-treesitter.configs",
		init = function()
			vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.opt.foldmethod = "expr"
			vim.opt.foldtext = ""
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		lazy = true,
		event = "LazyFile",
		-- HACK: https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/plugins/treesitter.lua#L87
		config = function()
			-- If treesitter is already loaded, we need to run config again for textobjects
			if User.util.is_loaded("nvim-treesitter") then
				local opts = User.util.get_plugin_opts("nvim-treesitter")
				require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })
			end

			-- When in diff mode, we want to use the default
			-- vim text objects c & C instead of the treesitter ones.
			local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
			local configs = require("nvim-treesitter.configs")
			for name, fn in pairs(move) do
				if name:find("goto") == 1 then
					move[name] = function(q, ...)
						if vim.wo.diff then
							local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
							for key, query in pairs(config or {}) do
								if q == query and key:find("[%]%[][cC]") then
									vim.cmd("normal! " .. key)
									return
								end
							end
						end
						return fn(q, ...)
					end
				end
			end
		end,
	},
	-- Show context of the current function
	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = true,
		event = "LazyFile",
		opts = { mode = "cursor", max_lines = 3 },
		init = function()
			User.util.on_load("snacks.nvim", function()
				local tsc = User.util.lazy_require("treesitter-context")
				Snacks.toggle({
					name = "Treesitter Context",
					get = function()
						return tsc.enabled()
					end,
					set = function(state)
						if state then
							tsc.enable()
						else
							tsc.disable()
						end
					end,
				}):map("<leader>ut")
			end)
		end,
	},
	{ "RRethy/nvim-treesitter-endwise", lazy = true, event = "LazyFile" },
}
