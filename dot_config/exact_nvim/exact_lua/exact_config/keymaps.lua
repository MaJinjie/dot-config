local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })
map("n", "<C-/>", "<C-w>w", { desc = "Go to last Window", remap = true })

-- Resize window using <ctrl+Shift> arrow keys
map("n", "<C-up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ":", ":<c-g>u")
map("i", ";", ";<c-g>u")

-- quickfix list
map("n", "[q", "<cmd>cprev<cr>", { desc = "Previous Quickfix" })
map("n", "]q", "<cmd>cnext<cr>", { desc = "Next Quickfix" })

-- location list
map("n", "[l", "<cmd>lprev<cr>", { desc = "Previous Location" })
map("n", "]l", "<cmd>lnext<cr>", { desc = "Next Location" })

-- windows
map("n", "_", "<C-w>s", { desc = "Split Window Below", remap = true })
map("n", "|", "<C-w>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wx", "<C-W>c", { desc = "Delete Window", remap = true })

-- buffers
map("n", "[b", "<cmd>execute 'bprev' . v:count1<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>execute 'bnext' . v:count1<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Last Buffer" })

-- tabs
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
map("n", "<leader><tab><tab>", "<cmd>tabnext #<cr>", { desc = "Switch Tabpage" })

-- diagnostic
-- stylua: ignore start
map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Line Diagnostics" })
map("n", "]d", function() vim.diagnostic.jump({count = 1,  wrap = true}) end, { desc = "Next Diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({count = -1, wrap = true}) end, { desc = "Prev Diagnostic" })
map("n", "]w", function() vim.diagnostic.jump({count = 1, severity = vim.diagnostic.severity.WARN, wrap = true}) end, { desc = "Next Warn Diagnostic" })
map("n", "[w", function() vim.diagnostic.jump({count = -1, severity = vim.diagnostic.severity.WARN, wrap = true}) end, { desc = "Prev Warn Diagnostic" })
map("n", "]e", function() vim.diagnostic.jump({count = 1, severity = vim.diagnostic.severity.ERROR, wrap = true}) end, { desc = "Next Error Diagnostic" })
map("n", "[e", function() vim.diagnostic.jump({count = -1, severity = vim.diagnostic.severity.ERROR, wrap = true}) end, { desc = "Prev Error Diagnostic" })
-- stylua: ignore end

-- Clear search on escape
map("n", "<esc>", "<Cmd>noh<CR><Esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- stylua: ignore
map( "n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", { desc = "Redraw / Clear hlsearch / Diff Update" })

if vim.g.neovide then
	map({ "n", "i" }, "<C-=>", function()
		local neovide_scale_factor = vim.g.neovide_scale_factor + vim.g.neovide_increment_scale_factor * vim.v.count1
		if neovide_scale_factor > vim.g.neovide_max_scale_factor then
			User.util.warn(
				"neovide_scale_factor has reached its maximum value " .. vim.g.neovide_max_scale_factor,
				{ title = "Neovide" }
			)
		end
		vim.g.neovide_scale_factor = math.min(neovide_scale_factor, vim.g.neovide_max_scale_factor)
	end, {
		desc = "Increase Neovide scale factor",
	})
	map({ "n", "i" }, "<C-->", function()
		local neovide_scale_factor = vim.g.neovide_scale_factor - vim.g.neovide_increment_scale_factor * vim.v.count1
		if neovide_scale_factor < vim.g.neovide_min_scale_factor then
			User.util.warn(
				"neovide_scale_factor has reached its minimum value " .. vim.g.neovide_min_scale_factor,
				{ title = "Neovide" }
			)
		end
		vim.g.neovide_scale_factor = math.max(neovide_scale_factor, vim.g.neovide_min_scale_factor)
	end, {
		desc = "Decrease Neovide scale factor",
	})
	map({ "n", "i" }, "<C-0>", function()
		vim.g.neovide_scale_factor = vim.g.neovide_initial_scale_factor
	end, {
		desc = "Reset Neovide scale factor to default",
	})
end
