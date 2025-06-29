return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    use_image_nvim = false,

    close_if_last_window = true,
    popup_border_style = "",
    sources = { "filesystem", "buffers", "git_status" },
    source_selector = { winbar = true },
    default_component_configs = {
      git_status = {
        symbols = User.config.icons.git
      }
    },
    filesystem = {
      hijack_netrw_behavior = "open_current",
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
        ["<space>"] = "none",
        ["Y"] = {
          function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg("+", path, "c")
          end,
          desc = "Copy Path to Clipboard",
        },
        ["O"] = {
          function(state)
            require("lazy.util").open(state.tree:get_node().path, { system = true })
          end,
          desc = "Open with System Application",
        },
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
  },
  config = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end

    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED,   handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
    require("neo-tree").setup(opts)
  end,
  -- stylua: ignore
  keys = {
    { "<leader>fe", function() require("neo-tree.command").execute({ toggle = true, dir = User.root() }) end,     desc = "Explorer NeoTree (Root Dir)" },
    { "<leader>fE", function() require("neo-tree.command").execute({ toggle = true, dir = User.cwd() }) end,      desc = "Explorer NeoTree (Cwd)" },
    { "<leader>ge", function() require("neo-tree.command").execute({ source = "git_status", toggle = true }) end, desc = "Git Explorer", },
    { "<leader>be", function() require("neo-tree.command").execute({ source = "buffers", toggle = true }) end,    desc = "Buffer Explorer", },
  },
  deactivate = function() vim.cmd([[Neotree close]]) end,
}
