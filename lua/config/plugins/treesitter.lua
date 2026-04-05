return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		opts = {
			highlight = {
				enable = true,
			},
			indent = { enable = true },
		},
		config = function()
			require("nvim-treesitter.install").prefer_git = true
		end,
	},
}
