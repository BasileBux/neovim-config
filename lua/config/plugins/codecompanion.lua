return {
	{
		"olimorris/codecompanion.nvim",
		config = function()
			require("codecompanion").setup({
				-- Owned: gemini, anthropic, copilot
				adapters = {
					http = {
						gemini = function()
							return require("codecompanion.adapters").extend("gemini", {
								name = "gemini_better",
								schema = {
									model = {
										default = "gemini-2.5-pro-preview-03-25",
									},
								},
							})
						end,
						openai = function()
							return require("codecompanion.adapters").extend("openai", {
								name = "openai",
								schema = {
									model = {
										default = "gpt-5-2025-08-07",
									},
								},
							})
						end,

						copilot = function()
							return require("codecompanion.adapters").extend("copilot", {
								name = "copilot",
								schema = {
									model = {
										default = "claude-sonnet-4",
									},
								},
							})
						end,

						anthropic = function()
							return require("codecompanion.adapters").extend("anthropic", {
								name = "anthropic",
								schema = {
									model = {
										default = "claude-sonnet-4-20250514",
									},
								},
							})
						end,

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
					-- Available: "copilot", "anthropic", "gemini", "openai"
					chat = {
						-- adapter = "copilot", -- basically free (but limited)
						adapter = "moonshot",
					},
					inline = {
						adapter = "copilot",
					},
				},
				opts = {},
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
}
