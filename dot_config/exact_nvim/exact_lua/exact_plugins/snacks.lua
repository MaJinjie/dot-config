return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			indent = { enabled = true },
			scope = { enabled = true },
			dashboard = { enabled = true },
			words = { enabled = true },
			input = { enabled = true },
			notifier = { enabled = true },
			picker = { enabled = true },
		},
	},
	{
		"folke/snacks.nvim",
		opts = {
			picker = {
				icons = {
					git = User.config.icons.git,
					kinds = User.config.icons.kinds,
				},
				win = {
					input = {
						keys = {
							["<C-w>"] = { "<c-s-w>", mode = "i", expr = true, desc = "delete word" },
							["<C-u>"] = { "<c-s-u>", mode = "i", expr = true, desc = "delete line" },

							["/"] = "toggle_focus",

							["<CR>"] = { "confirm", mode = { "n", "i" } },
							["<c-s>"] = { "edit_split", mode = { "i", "n" } },
							["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
							["<c-t>"] = { "tab", mode = { "n", "i" } },

							["<Esc>"] = "close",
							["q"] = "close",
							["<C-c>"] = { "cancel", mode = { "n", "i" } },

							["<C-j>"] = { "list_down", mode = { "i", "n" } },
							["<C-k>"] = { "list_up", mode = { "i", "n" } },
							["<Down>"] = { "list_down", mode = { "i", "n" } },
							["<Up>"] = { "list_up", mode = { "i", "n" } },
							["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },

							["<C-n>"] = { "history_forward", mode = { "i", "n" } },
							["<C-p>"] = { "history_back", mode = { "i", "n" } },

							["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
							["<Tab>"] = { "select_and_next", mode = { "i", "n" } },

							["<C-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
							["<C-f>"] = { "preview_scroll_down", mode = { "i", "n" } },

							["<C-r>#"] = { "insert_alt", mode = "i" },
							["<C-r>%"] = { "insert_filename", mode = "i" },
							["<C-r><c-a>"] = { "insert_cWORD", mode = "i" },
							["<C-r><c-f>"] = { "insert_file", mode = "i" },
							["<C-r><c-l>"] = { "insert_line", mode = "i" },
							["<C-r><c-p>"] = { "insert_file_full", mode = "i" },
							["<C-r><c-w>"] = { "insert_cword", mode = "i" },

							["<C-l>h"] = { "layout_left", mode = "i" },
							["<C-l>j"] = { "layout_bottom", mode = "i" },
							["<C-l>k"] = { "layout_top", mode = "i" },
							["<C-l>l"] = { "layout_right", mode = "i" },

							["<C-g>g"] = { "toggle_live", mode = { "i", "n" } },
							["<C-g>f"] = { "toggle_follow", mode = { "i", "n" } },
							["<C-g>h"] = { "toggle_hidden", mode = { "i", "n" } },
							["<C-g>i"] = { "toggle_ignored", mode = { "i", "n" } },
							["<C-g>m"] = { "toggle_maximize", mode = { "i", "n" } },
							["<C-g>p"] = { "toggle_preview", mode = { "i", "n" } },
							["<C-g>?"] = { "toggle_help_list", mode = { "i", "n" } },
							["<C-g>a"] = { "select_all", mode = { "n", "i" } },

							["<C-.>"] = { "toggle_hidden", mode = { "i", "n" } },
							["<C-o>"] = { "cycle_win", mode = { "i", "n" } },
							["<C-q>"] = { "qflist", mode = { "i", "n" } },
						},
					},
					list = {
						keys = {
							["<CR>"] = "confirm",
							["<C-s>"] = "edit_split",
							["<C-v>"] = "edit_vsplit",
							["<C-t>"] = "tab",

							["<Esc>"] = "close",
							["q"] = "close",
							["<C-c>"] = "cancel",

							["<C-j>"] = "list_down",
							["<C-k>"] = "list_up",
							["<C-n>"] = "list_down",
							["<C-p>"] = "list_up",
							["<Down>"] = "list_down",
							["<Up>"] = "list_up",
							["j"] = "list_down",
							["k"] = "list_up",
							["G"] = "list_bottom",
							["gg"] = "list_top",

							["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
							["<Tab>"] = { "select_and_next", mode = { "n", "x" } },

							["<C-u>"] = "list_scroll_up",
							["<C-d>"] = "list_scroll_down",
							["<C-b>"] = "preview_scroll_up",
							["<C-f>"] = "preview_scroll_down",

							["<C-l>h"] = "layout_left",
							["<C-l>j"] = "layout_bottom",
							["<C-l>k"] = "layout_top",
							["<C-l>l"] = "layout_right",

							["K"] = "inspect",
							["zb"] = "list_scroll_bottom",
							["zt"] = "list_scroll_top",
							["zz"] = "list_scroll_center",

							["<C-g>f"] = "toggle_follow",
							["<C-g>h"] = "toggle_hidden",
							["<C-g>i"] = "toggle_ignored",
							["<C-g>m"] = "toggle_maximize",
							["<C-g>p"] = "toggle_preview",

							["/"] = "toggle_focus",
							["i"] = "focus_input",
							["a"] = "focus_input",

							["<C-.>"] = "toggle_hidden",
							["<C-q>"] = "qflist",
							["<C-o>"] = "cycle_win",

							["<C-a>"] = "select_all",
							["?"] = "toggle_help_list",
						},
					},
					preview = {
						keys = {
							["<Esc>"] = "close",
							["q"] = "close",
							["<C-c>"] = "cancel",

							["/"] = "toggle_focus",
							["i"] = "focus_input",
							["a"] = "focus_input",

							["<C-o>"] = "cycle_win",
						},
					},
				},
				layouts = {
					vertical = {
						layout = {
							width = 0.8,
							min_width = 120,
							height = 0.8,
							border = "none",
							box = "vertical",
							{ win = "preview", title = "{preview}", height = 0.4, border = "vpad" },
							{
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					},
					default = {
						layout = {
							box = "horizontal",
							width = 0.8,
							min_width = 120,
							height = 0.8,
							{
								box = "vertical",
								border = "rounded",
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{ win = "preview", title = "{preview}", border = "vpad", width = 0.4 },
						},
					},
				},
			},
			terminal = {
				win = { position = "float", height = 0.8, width = 0.7, border = "rounded" },
			},
		},
		init = function()
			vim.opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
			User.util.on_load("snacks.nvim", function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end

				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
				Snacks.toggle.diagnostics():map("<leader>ud")
				Snacks.toggle.line_number():map("<leader>ul")
				Snacks.toggle
					.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
					:map("<leader>uc")
				Snacks.toggle.treesitter():map("<leader>uT")
				Snacks.toggle
					.option("background", { off = "light", on = "dark", name = "Dark Background" })
					:map("<leader>ub")
				Snacks.toggle.inlay_hints():map("<leader>uh")
				Snacks.toggle.dim():map("<leader>uD")
			end)
		end,
    -- stylua: ignore
    keys = {
      -- fast
      { "<leader>,",       function() Snacks.picker.buffers({ layout = { preset = "vscode" } }) end,                                          desc = "Buffers" },
      { "<leader><space>", function() Snacks.picker.files({ cwd = User.root(), layout = { preset = "vscode" } }) end,                         desc = "Find Files (Root Dir)" },
      { "<leader>/",       function() Snacks.picker.grep({ cwd = User.root(), layout = { preset = "vertical" } }) end,                        desc = "Grep (Root Dir)" },

      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,                                                                            desc = "Buffers" },
      { "<leader>fB",      function() Snacks.picker.buffers({ hidden = true, nofile = true }) end,                                            desc = "Buffers (all)" },
      { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath "config" }) end,                                             desc = "Find Config File" },
      { "<leader>fC",      function() Snacks.picker.projects({ title = "Plugins", projects = Snacks.picker.util.rtp(), recent = false }) end, desc = "Find Plugins File" },
      { "<leader>ff",      function() Snacks.picker.files({ cwd = User.root() }) end,                                                         desc = "Find Files (Root Dir)" },
      { "<leader>fF",      function() Snacks.picker.files({ cwd = User.root.cwd() }) end,                                                     desc = "Find Files (Cwd)" },
      { "<leader>fr",      function() Snacks.picker.recent() end,                                                                             desc = "Recent" },
      { "<leader>fR",      function() Snacks.picker.recent({ filter = { cwd = true } }) end,                                                  desc = "Recent (Cwd)" },
      { "<leader>fp",      function() Snacks.picker.projects() end,                                                                           desc = "Projects" },

      -- grep
      { "<leader>sb",      function() Snacks.picker.lines() end,                                                                              desc = "Buffer Lines" },
      { "<leader>sB",      function() Snacks.picker.grep_buffers({ layout = { preset = "vertical" } }) end,                                   desc = "Grep Open Buffers" },
      { "<leader>sg",      function() Snacks.picker.grep({ cwd = User.root(), layout = { preset = "vertical" } }) end,                        desc = "Grep (Root Dir)" },
      { "<leader>sG",      function() Snacks.picker.grep({ cwd = User.root.cwd(), layout = { preset = "vertical" } }) end,                    desc = "Grep (Cwd)" },
      { "<leader>sp",      function() Snacks.picker.lazy() end,                                                                               desc = "Grep Plugin Spec" },
      { "<leader>sw",      function() Snacks.picker.grep_word({ cwd = User.root(), layout = { preset = "vertical" } }) end,                   desc = "Visual selection or word (Root Dir)", mode = { "n", "x" } },
      { "<leader>sW",      function() Snacks.picker.grep_word({ cwd = User.root.cwd(), layout = { preset = "vertical" } }) end,               desc = "Visual selection or word (Cwd)",      mode = { "n", "x" } },

      -- search
      { "<leader>s'",      function() Snacks.picker.marks() end,                                                                              desc = "Marks" },
      { '<leader>s"',      function() Snacks.picker.registers() end,                                                                          desc = "Registers" },
      { "<leader>s:",      function() Snacks.picker.command_history() end,                                                                    desc = "Command History" },
      { '<leader>s/',      function() Snacks.picker.search_history() end,                                                                     desc = "Search History" },
      { "<leader>s?",      function() Snacks.picker.keymaps() end,                                                                            desc = "Keymaps" },
      { "<leader>sa",      function() Snacks.picker.autocmds() end,                                                                           desc = "Autocmds" },
      { "<leader>sc",      function() Snacks.picker.commands() end,                                                                           desc = "Commands" },
      { "<leader>sd",      function() Snacks.picker.diagnostics_buffer() end,                                                                 desc = "Buffer Diagnostics" },
      { "<leader>sD",      function() Snacks.picker.diagnostics() end,                                                                        desc = "Diagnostics" },
      { "<leader>sh",      function() Snacks.picker.help() end,                                                                               desc = "Help Pages" },
      { "<leader>sH",      function() Snacks.picker.highlights() end,                                                                         desc = "Highlights" },
      { "<leader>si",      function() Snacks.picker.icons() end,                                                                              desc = "Icons" },
      { "<leader>sj",      function() Snacks.picker.jumps() end,                                                                              desc = "Jumps" },
      { "<leader>sl",      function() Snacks.picker.loclist() end,                                                                            desc = "Location List" },
      { "<leader>sm",      function() Snacks.picker.man() end,                                                                                desc = "Man Pages" },
      { "<leader>sU",      function() Snacks.picker.resume() end,                                                                             desc = "Resume" },
      { "<leader>sq",      function() Snacks.picker.qflist() end,                                                                             desc = "Quickfix List" },
      { "<leader>su",      function() Snacks.picker.undo() end,                                                                               desc = "Undotree" },

      -- git
      { "<leader>gf",      function() Snacks.picker.git_files({ cwd = User.root() }) end,                                                     desc = "Git Files (Root Dir)" },
      { "<leader>gF",      function() Snacks.picker.git_files({ cwd = User.root.cwd() }) end,                                                 desc = "Git Files (Cwd)" },
      { "<leader>gg",      function() Snacks.picker.git_grep({ cwd = User.root(), lazyout = { preset = "vertical" } }) end,                   desc = "Git Grep (Root Dir)" },
      { "<leader>gG",      function() Snacks.picker.git_grep({ cwd = User.root.cwd(), lazyout = { preset = "vertical" } }) end,               desc = "Git Grep (Cwd)" },
      { "<leader>gd",      function() Snacks.picker.git_diff() end,                                                                           desc = "Git Diff (hunks)" },
      { "<leader>gs",      function() Snacks.picker.git_status() end,                                                                         desc = "Git Status" },
      { "<leader>gS",      function() Snacks.picker.git_stash() end,                                                                          desc = "Git Stash" },
      { "<leader>gl",      function() Snacks.picker.git_log_line({ layout = { preset = "vertical" } }) end,                                   desc = "Git Log Line" },
      { "<leader>gL",      function() Snacks.picker.git_log_file({ layout = { fullscreen = true } }) end,                                     desc = "Git Log File" },

      -- lsp
      { "<leader>ss",      function() Snacks.picker.lsp_symbols({ filter = User.config.kind_filter }) end,                                    desc = "LSP Symbols" },
      { "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols({ filter = User.config.kind_filter }) end,                          desc = "LSP Workspace Symbols" },

      -- ui
      { "<leader>uC",      function() Snacks.picker.colorschemes() end,                                                                       desc = "Colorschemes" },

      -- zen
      { "<leader>z",       function() Snacks.zen() end,                                                                                       desc = "Toggle Zen Mode" },

      -- zoom
      { "<leader>Z",       function() Snacks.zen.zoom() end,                                                                                  desc = "Toggle Zoom" },

      -- terminal
      { "<C-.>",           function() Snacks.terminal() end,   desc = "Float Terminal", mode = { "i", "n", "t" } },

      -- scratch 
      { "<leader>.",       function() Snacks.scratch() end,                                                                                   desc = "Toggle Scratch Buffer" },

      -- noice/notify
      { "<leader>sn",      function() Snacks.picker.notifications() end,                                                                      desc = "Notification History (Notify)" },
      { "<leader>nn",      function() Snacks.notifier.show_history() end,                                                                     desc = "Show Notification History" },
      { "<leader>un",      function() Snacks.notifier.hide() end,                                                                             desc = "Dismiss All Notifications" },

      -- todo-comments
      { "<leader>st",      function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end,                             desc = "Todo/Fix/Fixme" },
      { "<leader>sT",      function() Snacks.picker.todo_comments() end,                                                                      desc = "Todo" },

      -- yanky
      { "<leader>sy",       function() Snacks.picker.yanky() end,                                                                              desc = "Open Yank History" },

      -- custom
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.8,
            height = 0.8,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    }
,
	},
}
