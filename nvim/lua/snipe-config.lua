require("snipe").setup({
    hints = {
        dictionary = "1234567890asdfg",
    }
})
vim.keymap.set("n", "<leader><leader>", function() require("snipe").open_buffer_menu() end)
