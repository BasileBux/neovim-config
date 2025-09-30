return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()

			-- Key mappings
			vim.keymap.set("n", "<leader>t", function()
				harpoon:list():add()
			end, { desc = "Add file to harpoon" })

			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			for i = 1, 9 do
				vim.keymap.set("n", "<leader>" .. i, function()
					harpoon:list():select(i)
				end, { desc = "Go to harpoon mark " .. i })
			end

			-- Navigation between harpooned files
			vim.keymap.set("n", "<C-j>", function()
				harpoon:list():prev()
			end, { desc = "Previous harpoon file" })

			vim.keymap.set("n", "<C-k>", function()
				harpoon:list():next()
			end, { desc = "Next harpoon file" })
		end,
	},
}
