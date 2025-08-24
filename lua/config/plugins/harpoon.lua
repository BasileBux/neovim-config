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

			vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			-- Quick navigation to specific marks
			-- vim.keymap.set("n", "<leader>1", function()
			-- 	harpoon:list():select(1)
			-- end, { desc = "Go to harpoon mark 1" })
			--
			-- vim.keymap.set("n", "<leader>2", function()
			-- 	harpoon:list():select(2)
			-- end, { desc = "Go to harpoon mark 2" })
			--
			-- vim.keymap.set("n", "<leader>3", function()
			-- 	harpoon:list():select(3)
			-- end, { desc = "Go to harpoon mark 3" })

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
