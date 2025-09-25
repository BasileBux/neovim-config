-- [[ Basic Autocommands ]]

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = highlight_group,
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 75 })
  end
})

-- Remove trailing whitespace on save
-- autocmd('BufWritePre', {
--   pattern = '',
--   command = '%s/\\s\\+$//e'
-- })

-- Auto-resize splits when Vim window is resized
autocmd('VimResized', {
  pattern = '*',
  command = 'wincmd ='
})

-- Automatically reload files changed outside of Neovim
autocmd({ 'FocusGained', 'BufEnter' }, {
  pattern = '*',
  command = 'checktime'
})

-- Set indent settings for specific file types
autocmd('FileType', {
  pattern = { 'c', 'cpp', 'h', 'hpp', 'cc', 'hh' },
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.opt.softtabstop = 4
  end
})
