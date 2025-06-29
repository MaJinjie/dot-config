---@class user.lsp
local M = {}

M.support = setmetatable({}, {
	__call = function(self, t, opts)
		for n, f in pairs(self) do
			if t[n] ~= nil and not f(t[n], opts) then
				return false
			end
		end
		return true
	end,
})

---@param ft string|{[number]: string, exclude?: boolean}|nil
---@param opts user.lsp.Opts
---@return boolean
function M.support.ft(ft, opts)
	if ft == nil then
		return true
	end

	local fts = type(ft) == "table" and ft or { ft } ---@type {[number]: string, exclude?: boolean}
	local exclude = fts.exclude == true
	local filetype = vim.bo[opts.bufnr].filetype

	local ok = false
	for _, f in ipairs(fts) do
		if f == filetype then
			ok = true
			break
		end
	end
	return exclude ~= ok
end

---@param method string|string[]|nil
---@param opts user.lsp.Opts
---@return boolean
function M.support.has(method, opts)
	if method == nil then
		return true
	end
	local methods = type(method) == "table" and method or { method }
	---@cast methods string[]
	for _, m in ipairs(methods) do
		if not opts.client:supports_method(m, opts.bufnr) then
			return false
		end
	end
	return true
end

---@param fn boolean|fun(opts: user.lsp.Opts)|nil
---@param opts user.lsp.Opts
---@return boolean
function M.support.cond(fn, opts)
	if type(fn) == "function" then
		return fn(opts) ~= false
	else
		return fn ~= false
	end
end

local function get_kv(set, override)
	local map = {}
	for k, v in pairs(set) do
		if type(k) == "string" then
			map[k] = v
		end
	end
	for k, v in pairs(override) do
		if v == vim.NIL then
			map[k] = nil
			override[k] = nil
		end
	end
	return vim.tbl_extend("keep", map, override)
end

M.apply = setmetatable({}, {
	__call = function(self, t, opts)
		for n, f in pairs(self) do
			if t[n] ~= nil then
				f(t[n], opts)
			end
		end
	end,
})
---@param config? user.lsp.config.diagnostic
---@param opts user.lsp.Opts
function M.apply.diagnostic(config, opts)
	if config == nil then
		return
	end

	local ns = vim.lsp.diagnostic.get_namespace(opts.client.id)

	local enabled = config.enabled
	if enabled ~= nil then
		if type(enabled) == "function" then
			enabled = enabled(opts)
		end
		---@cast enabled boolean
		vim.diagnostic.enable(enabled, { bufnr = opts.bufnr, ns_id = ns })
	end

	vim.diagnostic.config(config, ns)
end

---@param config? user.lsp.config.keys
---@param opts user.lsp.Opts
function M.apply.keys(config, opts)
	if config == nil then
		return
	end

	for _, key in ipairs(config) do
		if M.support(key, opts) then
			vim.keymap.set(
				key[1],
				key[2],
				key[3],
				get_kv(key, {
					silent = true,
					buffer = opts.bufnr,
					ft = vim.NIL,
					has = vim.NIL,
					cond = vim.NIL,
				})
			)
		end
	end
end

---@param config? user.lsp.config.hooks
---@param opts user.lsp.Opts
function M.apply.hooks(config, opts)
	if config == nil then
		return
	end

	for _, hook in ipairs(config) do
		if type(hook) == "table" and M.support(hook, opts) then
			hook = hook[1]
		end
		if type(hook) == "function" then
			hook(opts)
		end
	end
end

return M

---@class UserLspConfig
---@field enabled? boolean
---@field diagnostic? user.lsp.config.diagnostic
---@field keys? user.lsp.config.keys
---@field hooks? user.lsp.config.hooks
---@field opts? user.lsp.config.opts
---@field setup? user.lsp.config.setup

---@class user.lsp.config.diagnostic: vim.diagnostic.Opts
---@field enabled? boolean|fun(opts: user.lsp.Opts):boolean

---@alias user.lsp.config.keys user.lsp.config.key[]
---@class user.lsp.config.key: vim.keymap.set.Opts, user.lsp.support
---@field [1] string|string[]
---@field [2] string
---@field [3] string|fun()

---@alias user.lsp.config.hooks user.lsp.config.hook[]
---@alias user.lsp.config.hook fun(opts: user.lsp.Opts)|({[1]:fun(opts: user.lsp.Opts)}|user.lsp.support)

---@class user.lsp.config.opts: vim.lsp.ClientConfig,{}

---@alias user.lsp.config.setup fun(name:string, opts:user.lsp.config.opts):boolean?

---@class user.lsp.support
---@field ft? string|{[number]: string, exclude?: boolean}
---@field has? string|string[]
---@field cond? boolean|fun(opts: user.lsp.Opts):boolean

---@class user.lsp.Opts
---@field client vim.lsp.Client
---@field bufnr? number
