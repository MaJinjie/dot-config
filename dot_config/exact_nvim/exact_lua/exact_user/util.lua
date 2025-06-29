---@class user.util: LazyUtilCore
local M = setmetatable({}, { __index = require("lazy.core.util") })

function M.is_win()
	return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

---@param fn fun()
---@param opts? {ms?:number}
---@return fun()
function M.debounce(fn, opts)
	local timer = assert(vim.uv.new_timer())
	local ms = opts and opts.ms or 100
	return function()
		timer:start(ms, 0, vim.schedule_wrap(fn))
	end
end

---@generic R
---@param fn fun(...):R
---@param ... any
---@return fun():R
function M.wrap(fn, ...)
	---@diagnostic disable-next-line: return-type-mismatch
	return setmetatable({ fn = fn, argv = { ... } }, {
		__call = function(self)
			return self.fn(table.unpack(self.argv))
		end,
	})
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
	local ret = {}
	local seen = {}
	for _, v in ipairs(list) do
		if not seen[v] then
			table.insert(ret, v)
			seen[v] = true
		end
	end
	return ret
end

---@param name string
function M.get_plugin(name)
	return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
function M.has_plugin(plugin)
	return M.get_plugin(plugin) ~= nil
end

---@param name string
---@param ... string
function M.get_plugin_opts(name, ...)
	local plugin = M.get_plugin(name)
	if not plugin then
		return {}
	end

	local Plugin = require("lazy.core.plugin")
	local opts = Plugin.values(plugin, "opts", false)
	if select("#", ...) > 0 then
		return vim.tbl_get(opts, ...) or {}
	end
	return opts
end

function M.is_loaded(name)
	local Config = require("lazy.core.config")
	return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
	fn = vim.schedule_wrap(fn)
	if M.is_loaded(name) then
		fn(name)
	else
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyLoad",
			callback = function(event)
				if event.data == name then
					fn(name)
					return true
				end
			end,
		})
	end
end

return M
