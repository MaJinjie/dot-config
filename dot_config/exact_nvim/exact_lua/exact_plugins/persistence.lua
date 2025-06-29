return {
  "folke/persistence.nvim",
  lazy = true,
  event = "BufReadPre",
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>pl", function() require("persistence").load() end,                desc = "Restore Session" },
    { "<leader>pL", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
    { "<leader>ps", function() require("persistence").select() end,              desc = "Select Session" },
    { "<leader>pS", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
  },
}
