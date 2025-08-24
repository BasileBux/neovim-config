return {
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("cyberdream")
			require("cyberdream").setup({
				transparent = false,
			})
		end,
	},
}
