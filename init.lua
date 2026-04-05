--[[
 ▐ ▄  ▌ ▐·▪  • ▌ ▄ ·.      ▄▄·        ▐ ▄ ·▄▄▄▪   ▄▄ •
•█▌▐█▪█·█▌██ ·██ ▐███▪    ▐█ ▌▪▪     •█▌▐█▐▄▄·██ ▐█ ▀ ▪
▐█▐▐▌▐█▐█•▐█·▐█ ▌▐▌▐█·    ██ ▄▄ ▄█▀▄ ▐█▐▐▌██▪ ▐█·▄█ ▀█▄
██▐█▌ ███ ▐█▌██ ██▌▐█▌    ▐███▌▐█▌.▐▌██▐█▌██▌.▐█▌▐█▄▪▐█
▀▀ █▪. ▀  ▀▀▀▀▀  █▪▀▀▀    ·▀▀▀  ▀█▄▀▪▀▀ █▪▀▀▀ ▀▀▀·▀▀▀▀
--]]
--
-- Set <space> as the leader key
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

require("settings")

require("keymaps")

require("autocommands")

require("commands")

-- Custom modules
require("custom.scratch").setup()
require("custom.android").setup()
-- require("custom.boom") -- Funny but really tilting

require("lazy-bootstrap")

-- TODO: Problem here which sets the `echo &packpath` to the /nix/store which sucks
-- Maybe replace lazy completely with pack.add({}) and pack.load()?
require("lazy-plugins")

vim.opt.tabstop = 4

-- Better visual panes separation -> must be called at end
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#f578d1", bg = "NONE" })

-- The line beneath this is called `modeline`. See `:help modeline`
