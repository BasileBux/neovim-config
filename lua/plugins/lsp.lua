local lsp_servers = {
	"lua_ls",
	"basedpyright",
	"cmake",
	"clangd",
	"gopls",
	-- "ltex", -- Anoying because it shows grammar errors but might be useful
	"nil_ls",
	"qmlls",
	"tinymist",
	"ts_ls",
	"rust_analyzer",
}

vim.lsp.enable(lsp_servers)

local map = function(keys, func, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, func, { desc = "LSP: " .. desc })
end

map("<leader>h", vim.lsp.buf.hover, "[H]over Documentation")

map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype Definition")
map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

map("rn", vim.lsp.buf.rename, "[R]e[n]ame")
map("ga", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })

-- If we want to do something when an LSP server attaches to a buffer
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(event) end,
-- })

require("fidget").setup({})

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = false } }, -- ctrl + space to see docs
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust" },
})

-- Formatting
require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettier" },
		javascript = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		java = { "clang-format" },
		go = { "gofmt" },
		xml = { "xmlformat" },
		nix = { "nixfmt" },
		typst = { "typstyle" },
	},
})
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_fallback = true })
end)

-- Specific to neovim Lua, to get LSP features in this config file
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})
