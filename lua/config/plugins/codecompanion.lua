return {
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				-- Owned: gemini, anthropic, copilot
				adapters = {
					http = {
						-- Custom moonshot adapter (OpenAI compatible)
						moonshot = function()
							return require("codecompanion.adapters").extend("openai_compatible", {
								name = "moonshot",
								formatted_name = "Moonshot",
								env = {
									api_key = "MOONSHOT_API_KEY",
									url = "https://api.moonshot.ai",
									chat_url = "/v1/chat/completions",
									models_endpoint = "/v1/models",
								},
								schema = {
									model = {
										default = "kimi-k2-0905-preview",
									},
								},
							})
						end,
					},
				},

				strategies = {
					chat = {
						adapter = {
							name = "moonshot",
							model = "kimi-k2-0905-preview",
						},
						keymaps = {
							send = {
								modes = { n = "<CR>", i = "<C-CR>" },
								opts = {},
							},
						},
					},
					inline = {
						adapter = {
							name = "copilot",
							model = "claude-haiku-4.5",
						},
					},
				},
				opts = {},
			})
			require("config.plugins.custom-mods.codecompanion-fidget-spinner"):init()
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
		vim.api.nvim_set_keymap(
			"n",
			"<leader>cc",
			"<cmd>CodeCompanionChat Toggle<CR>",
			{ noremap = true, silent = true }
		),
	},
}
