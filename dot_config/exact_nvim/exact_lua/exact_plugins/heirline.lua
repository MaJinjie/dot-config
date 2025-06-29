local M = {}

--- Encode a position to a single value that can be decoded later
---@param line integer line number of position
---@param col integer column number of position
---@param winnr integer a window number
---@return integer position the encoded position
local function encode_pos(line, col, winnr)
	return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
end

--- Decode a previously encoded position to it's sub parts
---@param c integer the encoded position
---@return integer line, integer column, integer window
local function decode_pos(c)
	return bit.rshift(c, 16), bit.band(bit.rshift(c, 6), 1023), bit.band(c, 63)
end

function M.winbar()
	local opts = {
		depth = nil,
		sep = " ",
		ellipsis = "",
	}

	return {
		{
			provider = " ",
		},
		{
			init = function(self)
				self.path = User.root.cwd()
				self.name = vim.fn.fnamemodify(self.path, ":t")
				self.filetype = "directory"
			end,
			update = { "DirChanged" },
			{
				init = function(self)
					self.icon, self.icon_hl = require("nvim-web-devicons").get_icon(
						self.path,
						self.filetype,
						{ default = true, strict = true }
					)
				end,
				provider = function(self)
					return self.icon .. " "
				end,
				hl = function(self)
					return self.icon_hl
				end,
			},
			{
				provider = function(self)
					return self.name
				end,
			},
		},
		{
			provider = opts.sep,
		},
		{
			condition = function()
				return vim.bo.buftype == ""
			end,
			update = { "BufWinEnter" },
			init = function(self)
				self.path = vim.api.nvim_buf_get_name(0)
				self.name = vim.fn.fnamemodify(self.path, ":t")
				self.filetype = vim.bo.filetype
			end,
			{
				init = function(self)
					self.icon, self.icon_hl = require("nvim-web-devicons").get_icon(
						self.name,
						self.filetype,
						{ default = true, strict = true }
					)
				end,
				provider = function(self)
					return self.icon .. " "
				end,
				hl = function(self)
					return self.icon_hl
				end,
			},
			{
				provider = function(self)
					if self.path == "" then
						return "[" .. self.filetype:sub(1, 1):upper() .. self.filetype:sub(2):lower() .. "]"
					end
					return self.name
				end,
			},
		},
		{
			condition = function()
				return User.util.has_plugin("aerial.nvim")
			end,
			update = { "CursorMoved", "VimResized" },
			init = function(self)
				local symbols = require("aerial").get_location(true)
				local winnr = vim.api.nvim_win_get_number(0)
				local si, ei = 1, #symbols
				local remaining
				local childs = {}

				if opts.depth then
					remaining = #symbols > opts.depth
					si = remaining and ei - opts.depth + 1 or 1
				end

				for ii = si, ei do
					local symbol = symbols[ii]
					local child = {
						{ provider = opts.sep },
						{ provider = symbol.icon, hl = ("Aerial%sIcon"):format(symbol.kind) },
						{ provider = symbol.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "") },
						on_click = {
							minwid = encode_pos(symbol.lnum, symbol.col, winnr),
							callback = function(_, minwid)
								local lnum, col, winnr = decode_pos(minwid)
								local winid = assert(vim.fn.win_getid(winnr))
								vim.cmd("normal! m`") -- 设置跳转标记
								vim.api.nvim_win_set_cursor(winid, { lnum, col })
							end,
							name = "heirline_breadcrumbs",
						},
					}

					child = {
						child,
						ii == si and si ~= ei and not remaining and { provider = opts.sep .. opts.ellipsis } or {},
						flexible = ii,
					}

					table.insert(childs, child)
				end

				if remaining then
					table.insert(childs, 1, { provider = opts.sep .. opts.ellipsis })
				end
				self[1] = self:new(childs, 1)
			end,
		},
	}
end

return {
	"rebelot/heirline.nvim",
	lazy = true,
	event = "LazyFile",
	opts = {
		winbar = M.winbar(),
		opts = {
			disable_winbar_cb = function(args)
				local buftypes = { "", exclude = false }
				local filetypes = { "snacks_picker_preview", exclude = true }

				if #buftypes > 0 and vim.list_contains(buftypes, vim.bo[args.buf].buftype) == buftypes.exclude then
					return true
				end
				if #filetypes > 0 and vim.list_contains(filetypes, vim.bo[args.buf].filetype) == filetypes.exclude then
					return true
				end
				return false
			end,
		},
	},
}
