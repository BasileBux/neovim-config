return {
	{
		"dmtrKovalenko/fff.nvim",
		-- build = "cargo build --release",
		-- or if you are using nixos
		build = "nix run .#release",
		opts = {
			-- pass here all the options
			-- 🦦 🪿 🪼
			prompt = "🦦 ",
		},
		keys = {
			{
				"<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
				function()
					require("fff").find_files() -- or find_in_git_root() if you only want git files
				end,
				desc = "Open file picker",
			},
			{ -- Legacy keybinding
				"<leader>sg",
				function()
					require("fff").live_grep() -- or live_grep_in_git_root() if you only want git files
				end,
				desc = "Open live grep picker",
			},
			{
				"<leader>gg",
				function()
					require("fff").live_grep() -- or live_grep_in_git_root() if you only want git files
				end,
				desc = "Open live grep picker",
			},
			{
				"<leader>sz",
				function()
					require("fff").live_grep({
						grep = {
							modes = { "fuzzy", "plain" },
						},
					})
				end,
				desc = "Live fffuzy grep",
			},
		},
	},
}
