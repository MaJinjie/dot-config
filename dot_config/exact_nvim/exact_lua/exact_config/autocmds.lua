local augroup = function(name, clear)
	return vim.api.nvim_create_augroup("user." .. name, { clear = clear ~= false })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	callback = function()
		if vim.o.buftype ~= "nofile" then
			vim.cmd("checktime")
		end
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize"),
	command = "wincmd =",
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_location"),
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_location then
			return
		end
		vim.b[buf].last_location = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = { "checkhealth", "help", "notify", "qf", "startuptime" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
		end)
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- set options for some filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("set_options"),
	pattern = { "man", "qf", "checkhealth", "query" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
	end,
})

if vim.g.neovide then
	-- Only enables IME in input mode and command mode
	vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
		group = augroup("neovide_ime"),
		callback = function(ev)
			if ev.event:match("Leave$") then
				vim.g.neovide_input_ime = false
			else
				vim.g.neovide_input_ime = true
			end
		end,
	})
end
