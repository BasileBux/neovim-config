local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 75 })
	end,
})

-- Auto-resize splits when Vim window is resized
autocmd("VimResized", {
	pattern = "*",
	command = "wincmd =",
})

-- Automatically reload files changed outside of Neovim
autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
})
