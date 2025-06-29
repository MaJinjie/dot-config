return {
	"lewis6991/gitsigns.nvim",
	lazy = true,
	event = "LazyFile",
	opts = {
		current_line_blame = true,
    -- stylua: ignore
    on_attach = function(buffer)
      local gitsigns = require("gitsigns")

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buffer
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function() gitsigns.nav_hunk('next') end, { desc = "Jump to next git hunk" })
      map('n', '[h', function() gitsigns.nav_hunk('prev') end, { desc = "Jump to prev git hunk" })

      -- Actions
      map('n', '<leader>ghs', gitsigns.stage_hunk, { desc = "Stage the current hunk" })
      map('n', '<leader>ghr', gitsigns.reset_hunk, { desc = "Reset the current hunk" })
      map('v', '<leader>ghs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = "Stage the selected lines as a hunk" })
      map('v', '<leader>ghr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end,
        { desc = "Reset the selected lines as a hunk" })
      map('n', '<leader>ghS', gitsigns.stage_buffer, { desc = "Stage the entire buffer" })
      map('n', '<leader>ghR', gitsigns.reset_buffer, { desc = "Reset the entire buffer" })

      -- Preview
      map('n', '<leader>ghp', gitsigns.preview_hunk_inline, { desc = "Inline Preview the current hunk" })
      map('n', '<leader>ghP', gitsigns.preview_hunk, { desc = "Popup Preview the current hunk" })

      -- Quickfix
      map("n", "<leader>ghq", gitsigns.setqflist, { desc = "Quickfix Git hunks" })
      map("n", "<leader>ghQ", function() gitsigns.setqflist("all") end, { desc = "Quickfix All Git hunks" })

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = "Select the current hunk as a text object" })
    end,
	},
}
