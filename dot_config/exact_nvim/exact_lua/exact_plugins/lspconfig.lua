local M = {}

M._default = nil
function M.get()
	if M._default then
		return M._default
	end
  -- stylua: ignore
	local default = {
    keys = {
      { "n",          "gd",         function() vim.lsp.buf.definition() end,            desc = "Goto Definition",            has = "textDocument/definition" },
      { "n",          "gr",         function() vim.lsp.buf.references() end,            desc = "Goto References",            has = "textDocument/references" },
      { "n",          "gI",         function() vim.lsp.buf.implementation() end,        desc = "Goto Implementation",        has = "textDocument/implementation" },
      { "n",          "gy",         function() vim.lsp.buf.type_definition() end,       desc = "Goto TypeDefinition",        has = "textDocument/typeDefinition" },
      { "n",          "gD",         function() vim.lsp.buf.declaration() end,           desc = "Goto Declaration",           has = "textDocument/declaration" },
      { "n",          "K",          function() vim.lsp.buf.hover() end,                 desc = "Hover",                      has = "textDocument/hover" },
      { "n",          "gk",         function() vim.lsp.buf.signature_help() end,        desc = "Goto SignatureHelp",         has = "textDocument/signatureHelp" },
      { "i",          "<c-k>",      function() return vim.lsp.buf.signature_help() end, desc = "Signature Help",             has = "textDocument/signatureHelp", },
      { "n",          "<leader>cr", function() vim.lsp.buf.rename() end,                desc = "Rename Symbol",              has = "textDocument/rename" },
      { "n",          "<leader>cR", function() Snacks.rename.rename_file() end,         desc = "Rename File",                has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
      { { "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end,           desc = "Code Action",                has = "textDocument/codeAction", },
      { { "n", "v" }, "<leader>cc", function() vim.lsp.codelens.run() end,              desc = "Run Codelens",               has = "codeLens" },
      { "n",          "<leader>cC", function() vim.lsp.codelens.refresh() end,          desc = "Refresh & Display Codelens", has = "codeLens" },
      { "n", "<a-n>", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", has = "textDocument/documentHighlight", cond = Snacks.words.is_enabled },
      { "n", "<a-p>", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", has = "textDocument/documentHighlight", cond = Snacks.words.is_enabled }
    },
		hooks = {
			{ function(opts) vim.lsp.inlay_hint.enable(true, { bufnr = opts.bufnr }) end, has = "textDocument/inlayHint" },
			{
				function(opts)
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = opts.bufnr,
						callback = User.util.debounce(function()
							vim.lsp.codelens.refresh({ bufnr = opts.bufnr })
						end),
					})
				end,
				has = "textDocument/codeLens",
				cond = false,
			},
		},
		opts = {},
	}

	default.opts.capabilities = require("blink-cmp").get_lsp_capabilities(default.opts.capabilities, true)

	M._default = default
	return M._default
end

return {
	"neovim/nvim-lspconfig",
	event = "LazyFile",
	---@type table<string, UserLspConfig>
	opts = {
		-- lua
		lua_ls = {
			enabled = true,
			opts = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						codeLens = { enable = false },
						completion = { callSnippet = "Replace" },
						doc = { privateName = { "^_" } },
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = "Disable",
							semicolon = "Disable",
							arrayIndex = "Disable",
						},
					},
				},
			},
		},

		-- yaml
		yamlls = {
			enabled = true,
			-- NOTE: https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/plugins/extras/lang/yaml.lua#L16
			opts = {
				-- Have to add this for yamlls to understand that we support line folding
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.yaml.schemas = vim.tbl_deep_extend(
						"force",
						new_config.settings.yaml.schemas or {},
						require("schemastore").yaml.schemas()
					)
				end,
				settings = {
					redhat = { telemetry = { enabled = false } },
					yaml = {
						keyOrdering = false,
						format = {
							enable = true,
						},
						validate = true,
						schemaStore = {
							-- Must disable built-in schemaStore support to use
							-- schemas from SchemaStore.nvim plugin
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
					},
				},
			},
		},

		-- json
		jsonls = {
			enabled = true,
			-- NOTE: https://github.com/LazyVim/LazyVim/blob/25abbf546d564dc484cf903804661ba12de45507/lua/lazyvim/plugins/extras/lang/json.lua#L23
			opts = {
				-- lazy-load schemastore when needed
				on_new_config = function(new_config)
					new_config.settings.json.schemas = new_config.settings.json.schemas or {}
					vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
				end,
				settings = {
					json = {
						format = {
							enable = true,
						},
						validate = { enable = true },
					},
				},
			},
		},

		-- toml
		taplo = { enabled = true },

		-- nix
		nil_ls = { enabled = true },

		-- rust
		rust_analyzer = { enabled = false },
		-- bacon_ls = { enabled = true },
	},
	config = function(_, servers)
		local default = M.get()

		for name, server in pairs(servers) do
			if server.enabled ~= false then
				local opts = vim.tbl_deep_extend("force", vim.deepcopy(default.opts), server.opts or {})

				if server.setup then
					server.setup(name, opts)
				elseif default.setup then
					default.setup(name, opts)
				else
					require("lspconfig")[name].setup(opts)
				end
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local bufnr = args.buf ---@type number
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
				local name = client.name
				local opts = { client = client, bufnr = bufnr }
				User.lsp.apply(default, opts)
				User.lsp.apply(servers[name] or {}, opts)
			end,
		})
	end,
}
