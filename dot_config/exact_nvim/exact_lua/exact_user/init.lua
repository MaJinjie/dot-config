---@class user
---@field util user.util
---@field root user.root
---@field lsp user.lsp
---@field config user.config
local M = vim._defer_require("user", {
	util = ..., ---@module 'user.util'
	root = ..., ---@module 'user.root'
	lsp = ..., ---@module 'user.lsp'
	config = ..., ---@module 'user.config'
})

_G.User = M
