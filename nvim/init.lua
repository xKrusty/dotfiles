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

vim.o.incsearch = true

vim.o.termguicolors = true

vim.o.signcolumn = "yes"
vim.o.cursorline = true

vim.o.updatetime = 2000 -- for cursorhold event

local map = vim.api.nvim_set_keymap
local silent = { silent = true, noremap = true }
map("", "<Space>", "<Nop>", silent)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- custom keymaps
vim.keymap.set("n", "<C-m>", "<Cmd>bn<CR>", { silent = true })
vim.keymap.set("n", "<C-n>", "<Cmd>bp<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", "<Cmd>noh<CR>", {silent = true })

-- custom commands
vim.api.nvim_create_user_command('Bc', function() vim.cmd("b#|bd#") end, { nargs = 0 }) -- close current buffer and swap to previous buffer (this keeps windows/tabs open)


-- load plugin configs
require("lazy-config")
require("rose-pine").setup()
vim.cmd("colorscheme rose-pine-moon")
require("lsp-config")
require("telescope-config")
require("treesitter-config")
require("dap-config")
require("cmp-config")
require("lualine-config")
require("bufferline-config")
require("scrollbar-config")
require("ufo-config")
require("dressing-config")

