return {
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {
			open_cmd = "qutebrowser %s > /dev/null 2>&1",
			invert_colors = "never", -- "always", "never", "auto"
		},
	},
}
