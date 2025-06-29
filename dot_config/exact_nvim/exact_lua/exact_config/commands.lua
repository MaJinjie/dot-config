vim.api.nvim_create_user_command("W", function(args)
	vim.print(args)
	local opt_value = vim.g.autoformat
	vim.g.autoformat = not opt_value
	vim.cmd.w({ args.fargs[1], bang = args.bang })
	vim.g.autoformat = opt_value
end, { nargs = "?", bang = true, range = true, complete = "file", desc = "Save With Reverse Format" })
