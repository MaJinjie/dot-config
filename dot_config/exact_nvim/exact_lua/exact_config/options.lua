vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Enable auto format, used for BufWritePre
vim.g.autoformat = true

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.colorcolumn = "80"
opt.cmdheight = 0
opt.expandtab = true -- Use spaces instead of tabs
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --color=never --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "stack"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.switchbuf = { "useopen", "uselast" } -- Controls the behavior when switching between buffers.
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.swapfile = true
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.smoothscroll = true

-- diagnostic
vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	virtual_text = {
		spacing = 4,
		source = "if_many",
		-- prefix = function(diagnostic)
		-- 	local s_severity = vim.diagnostic.severity[diagnostic.severity]
		-- 	return User.config.icons.diagnostics[s_severity:lower()] or "●"
		-- end,
		prefix = "●",
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = User.config.icons.diagnostics.error,
			[vim.diagnostic.severity.WARN] = User.config.icons.diagnostics.warn,
			[vim.diagnostic.severity.HINT] = User.config.icons.diagnostics.hint,
			[vim.diagnostic.severity.INFO] = User.config.icons.diagnostics.info,
		},
	},
})

-- neovide
if vim.g.neovide then
	vim.o.guifont = "FiraCode Nerd Font,JetBrainsMono Nerd Font:h12"
	-- 设置窗口显示比例
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_initial_scale_factor = vim.g.neovide_scale_factor
	vim.g.neovide_increment_scale_factor = 0.1
	vim.g.neovide_min_scale_factor = 0.7
	vim.g.neovide_max_scale_factor = 2.0
	-- 设置Padding
	vim.g.neovide_padding_top = 10
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_left = 10
	vim.g.neovide_padding_right = 0
	-- 设置窗口模糊(macos)
	vim.g.neovide_window_blurred = true
	-- 设置透明度
	vim.g.neovide_opacity = 0.8
	vim.g.neovide_normal_opacity = 0.8
	-- 增加下划线宽度
	vim.g.neovide_underline_stroke_scale = 2.0
	-- 键入时隐藏鼠标
	vim.g.neovide_hide_mouse_when_typing = true
	-- neovide 主题色彩 light dark auto
	vim.g.neovide_theme = "auto"
	-- 启动时使用上一次会话的窗口大小
	vim.g.neovide_remember_window_size = true

	-- animate
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_smooth_blink = true
	-- 为浮动窗口启用模糊效果
	-- vim.g.neovide_floating_blur = true
end
