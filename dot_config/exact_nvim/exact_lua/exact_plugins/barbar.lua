return {
  "romgrk/barbar.nvim",
  lazy = true,
  event = "LazyDash",
  opts = {
    auto_hide = 1,
    icons = {
      gitsigns = {
        added = { enabled = false },
        changed = { enabled = false },
        deleted = { enabled = false },
      },
    },
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWinLeave', text = "NeoTree", align = "center" },
    },
  },
  keys = {
    { "[b",          "<cmd>BufferPrevious<cr>",                   desc = "Prev Buffer" },
    { "]b",          "<cmd>BufferNext<cr>",                       desc = "Next Buffer" },
    { "[B",          "<cmd>BufferFirst<cr>",                      desc = "First Buffer" },
    { "]B",          "<cmd>BufferLast<cr>",                       desc = "Last Buffer" },

    { "<leader>bd",  "<cmd>BufferDelete<cr>",                     desc = "Delete Buffer" },
    { "<leader>bD",  "<cmd>BufferPickDelete<cr>",                 desc = "Pick Buffer to Delete" },

    { "<leader>bb",  "<cmd>e #<cr>",                              desc = "Switch to Last Buffer" },
    { "<leader>bB",  "<cmd>BufferPick<cr>",                       desc = "Pick Buffer" },

    { "<leader>bC",  "<cmd>BufferCloseAllButCurrent<cr>",         desc = "Close All But Current Buffer" },
    { "<leader>bP",  "<cmd>BufferCloseAllButPinned<cr>",          desc = "Close All But Pinned Buffers" },
    { "<leader>bO",  "<cmd>BufferCloseAllButCurrentOrPinned<cr>", desc = "Close All But Current/Pinned Buffers" },
    { "<leader>bV",  "<cmd>BufferCloseAllButVisible<cr>",         desc = "Close All But Visible Buffers" },

    { "<leader>bob", "<cmd>BufferOrderByBufferNumber<cr>",        desc = "Order Buffers by Number" },
    { "<leader>bon", "<cmd>BufferOrderByName<cr>",                desc = "Order Buffers by Name" },
    { "<leader>bod", "<cmd>BufferOrderByDirectory<cr>",           desc = "Order Buffers by Directory" },
    { "<leader>bol", "<cmd>BufferOrderByLanguage<cr>",            desc = "Order Buffers by Language" },
    { "<leader>bow", "<cmd>BufferOrderByWindowNumber<cr>",        desc = "Order Buffers by Window Number" },

    { "<leader>bh",  "<cmd>BufferScrollLeft<cr>",                 desc = "Scroll Buffer Left" },
    { "<leader>bl",  "<cmd>BufferScrollRight<cr>",                desc = "Scroll Buffer Right" },
    { "<leader>bH",  "<cmd>BufferCloseBuffersLeft<cr>",           desc = "Close Buffers to the Left" },
    { "<leader>bL",  "<cmd>BufferCloseBuffersRight<cr>",          desc = "Close Buffers to the Right" },

    { "<leader>bp",  "<cmd>BufferPin<cr>",                        desc = "Pin Buffer" },
    { "<leader>br",  "<cmd>BufferRestore<cr>",                    desc = "Restore Buffer" },
  }
}
