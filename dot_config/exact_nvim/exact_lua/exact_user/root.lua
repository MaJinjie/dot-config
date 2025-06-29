---@class user.root
---@overload fun(): string
local M = setmetatable({}, {
	__call = function(m, ...)
		return m.get(...)
	end,
})

---@class UserRoot
---@field paths string[]
---@field spec UserRootSpec

---@alias UserRootFn fun(buf: number): (string|string[])

---@alias UserRootSpec string|string[]|UserRootFn

---@type UserRootSpec[]
M.spec = { "lsp", { "^.git$", "^lua$" }, "cwd" }

---@type string[]
M.lsp_ignore = {}

M.detectors = {}

function M.detectors.cwd()
	return { vim.uv.cwd() }
end

function M.detectors.lsp(buf)
	local bufpath = M.bufpath(buf)
	if not bufpath then
		return {}
	end
	local roots = {} ---@type string[]
	local clients = vim.lsp.get_clients({ bufnr = buf })
	clients = vim.tbl_filter(function(client)
		return not vim.tbl_contains(M.lsp_ignore or {}, client.name)
	end, clients)
	for _, client in pairs(clients) do
		local workspace = client.config.workspace_folders
		for _, ws in pairs(workspace or {}) do
			roots[#roots + 1] = vim.uri_to_fname(ws.uri)
		end
		if client.root_dir then
			roots[#roots + 1] = client.root_dir
		end
	end
	return vim.tbl_filter(function(path)
		path = vim.fs.normalize(path)
		return path and bufpath:find(path, 1, true) == 1
	end, roots)
end

---@param patterns string[]|string
function M.detectors.pattern(buf, patterns)
	patterns = type(patterns) == "string" and { patterns } or patterns
	---@cast patterns string[]

	local path = M.bufpath(buf) or vim.uv.cwd()
	local pattern = vim.fs.find(function(name)
		for _, p in ipairs(patterns) do
			if name:match(p) then
				return true
			end
		end
		return false
	end, { path = path, upward = true })[1]
	return pattern and { vim.fs.dirname(pattern) } or {}
end

function M.bufpath(buf)
	return M.realpath(vim.api.nvim_buf_get_name(assert(buf)))
end

function M.realpath(path, normalize)
	if path == "" or path == nil then
		return nil
	end
	path = normalize and vim.fs.normalize(path) or path
	return vim.uv.fs_realpath(path) or path
end

---@param spec UserRootSpec
---@return UserRootFn
function M.resolve(spec)
	if M.detectors[spec] then
		return M.detectors[spec]
	elseif type(spec) == "function" then
		return spec
	end
	return function(buf)
		return M.detectors.pattern(buf, spec)
	end
end

---@param opts? { buf?: number, spec?: UserRootSpec[], all?: boolean }
function M.detect(opts)
	opts = opts or {}
	opts.spec = opts.spec or M.spec
	opts.buf = (opts.buf == nil or opts.buf == 0) and vim.api.nvim_get_current_buf() or opts.buf

	local ret = {} ---@type UserRoot[]
	for _, spec in ipairs(opts.spec) do
		local paths = M.resolve(spec)(opts.buf)
		paths = paths or {}
		paths = type(paths) == "table" and paths or { paths }
		local roots = {} ---@type string[]
		for _, p in ipairs(paths) do
			local pp = M.realpath(p)
			if pp and not vim.tbl_contains(roots, pp) then
				roots[#roots + 1] = pp
			end
		end
		table.sort(roots, function(a, b)
			return #a > #b
		end)
		if #roots > 0 then
			ret[#ret + 1] = { spec = spec, paths = roots }
			if opts.all == false then
				break
			end
		end
	end
	return ret
end

function M.info()
	local spec = M.spec

	local roots = M.detect({ all = true })
	local lines = {} ---@type string[]
	local first = true
	for _, root in ipairs(roots) do
		for _, path in ipairs(root.paths) do
			lines[#lines + 1] = ("- [%s] `%s` **(%s)**"):format(
				first and "x" or " ",
				path,
				type(root.spec) == "table" and table.concat(root.spec --[=[@as string[]]=], ", ") or root.spec
			)
			first = false
		end
	end
	lines[#lines + 1] = "```lua"
	lines[#lines + 1] = "root_spec = " .. vim.inspect(spec)
	lines[#lines + 1] = "```"
	User.util.info(lines, { title = "UserVim Roots" })
	return roots[1] and roots[1].paths[1] or vim.uv.cwd()
end

---@type table<number, string>
M.cache = {}

function M.setup()
	vim.api.nvim_create_user_command("UserRoot", function()
		M.info()
	end, { desc = "UserVim roots for the current buffer" })

	-- FIX: doesn't properly clear cache in neo-tree `set_root` (which should happen presumably on `DirChanged`),
	-- probably because the event is triggered in the neo-tree buffer, therefore add `BufEnter`
	-- Maybe this is too frequent on `BufEnter` and something else should be done instead??
	vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost", "DirChanged", "BufEnter" }, {
		group = vim.api.nvim_create_augroup("user.root_cache", { clear = true }),
		callback = function(event)
			M.cache[event.buf] = nil
		end,
	})
end

-- returns the root directory based on:
-- * lsp workspace folders
-- * lsp root_dir
-- * root pattern of filename of the current buffer
-- * root pattern of cwd
---@param opts? {normalize?:boolean, buf?:number, fallback?: boolean}
---@return string?
function M.get(opts)
	opts = opts or {}
	local buf = opts.buf or vim.api.nvim_get_current_buf()
	local ret = M.cache[buf]
	if not ret then
		local roots = M.detect({ all = false, buf = buf })
		ret = roots[1] and roots[1].paths[1] or (opts.fallback ~= false and M.cwd() or nil)
		M.cache[buf] = ret
	end
	if opts.normalize then
		return ret
	end
	return User.util.is_win() and ret:gsub("/", "\\") or ret
end

function M.git()
	local root = M.get()
	local git_root = vim.fs.find(".git", { path = root, upward = true })[1]
	local ret = git_root and vim.fn.fnamemodify(git_root, ":h") or root
	return ret
end

---@param winnr? number
---@param tabnr? number
function M.cwd(winnr, tabnr)
	if winnr or tabnr then
		return vim.fn.getcwd(winnr, tabnr)
	end
	return assert(vim.uv.cwd()) or ""
end

return M
