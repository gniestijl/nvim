local o = vim.o
local wo = vim.wo
local bo = vim.bo
local g = vim.g

g.mapleader = ','

-- buffer-local options
bo.tabstop = 2
bo.shiftwidth = 2
bo.softtabstop = 2
bo.expandtab = true

vim.api.nvim_exec ('language en_US', true)

-- global options
o.guifont = 'Cousine NF:h10'
o.mouse = "a"
