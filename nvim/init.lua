
vim.o.tabstop = 4       -- A tab character looks like 4 spaces
vim.o.softtabstop = 4   -- number of spaces inserted instead of tab character
vim.o.shiftwidth = 4    -- number of spaces inserted when indenting
vim.o.expandtab = true  -- pressing the tab key will insert spaces instead of a tab character
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.relativenumber = true
vim.o.number = true

vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false

--vim.o.hlsearch = false
vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.signcolumn = "yes"
vim.o.cursorline = true

vim.o.updatetime = 500 -- for cursorhold event



local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<C-m>", "<Cmd>bn<CR>", { silent = true })
vim.keymap.set("n", "<C-n>", "<Cmd>bp<CR>", { silent = true })

require("config.lazy")

require("rose-pine").setup()
vim.cmd("colorscheme rose-pine-moon")
require("lualine").setup()
require("bufferline").setup()
require("scrollbar").setup()

require("lsp")
require("telescope")
require("treesitter")
require("dap-config")
