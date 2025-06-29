return {
	"NeogitOrg/neogit",
	cmd = "Neogit",
	opts = {},
  -- stylua: ignore
  keys = {
    { "<leader>gn", function() require("neogit").open({cwd = User.root()}) end, desc = "Neogit (Root Dir)" },
    { "<leader>gN", function() require("neogit").open({cwd = User.root.cwd()}) end, desc = "Neogit (Cwd)" },
  },
}
