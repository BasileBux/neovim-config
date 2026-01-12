return {
	{
		dir = "/home/basileb/drunk-driver.nvim",
		name = "drunk-driver.nvim",
		config = function()
			require("drunk-driver").setup({
				linux_distribution = "Nixos",
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
