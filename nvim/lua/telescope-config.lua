local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fl", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
vim.keymap.set("n", "<leader>fm", builtin.marks)

require("telescope").setup({})

require("telescope").load_extension("undo")
