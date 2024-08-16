require("bufferline").setup({
    options = {
        numbers = "ordinal"
    }
})

vim.keymap.set("n", "<A-n>", ":BufferLineMovePrev<CR>")
vim.keymap.set("n", "<A-m>", ":BufferLineMoveNext<CR>")
vim.keymap.set("n", "<leader>mb", ":lua require'bufferline'.move_to(tonumber(vim.fn.input('Position: ')))<CR>", {buffer=0})
