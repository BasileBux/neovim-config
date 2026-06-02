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

-- Enable treesitter-based syntax highlighting if a parser is available for the filetype
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local lang = vim.bo.filetype
		if vim.treesitter.get_parser(0, lang, { error = false }) then
			vim.treesitter.start()
			vim.bo.syntax = "off"
		end
	end,
})
