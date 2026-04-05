require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

	-- "gc" to comment visual regions/lines
	{ "numToStr/Comment.nvim", opts = {} },

	require("config.plugins.gitsigns"),

	require("config.plugins.indent-blankline"),

	require("config.plugins.snacks"),

	require("config.plugins.telescope"),

	require("config.plugins.harpoon"),

	require("config.plugins.fff"),

	require("config.plugins.lspconfig"),

	require("config.plugins.conform"),

	require("config.plugins.blink-cmp"),

	require("config.plugins.surround"),

	-- Theme : There are many themes in `config.plugins.themes`
	-- require("config.plugins.themes.cyberdream"),
	require("config.plugins.themes.rose-pine"),

	require("config.plugins.todo-comments"),

	require("config.plugins.treesitter"),

	require("config.plugins.lualine"),

	require("config.plugins.markdown-preview"),

	require("config.plugins.typst-preview"),

	require("config.plugins.render-markdown"),

	require("config.plugins.toggleterm"),

	require("config.plugins.copilot"),

	require("config.plugins.codecompanion"),

	require("config.plugins.drunk-driver"),
}, {
	git = {
		timeout = 600,
	},
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})
