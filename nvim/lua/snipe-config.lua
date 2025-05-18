require("snipe").setup({
    ui = {
        position = "center",

        open_win_override = {
            border = "rounded",
        },

        preselect_current = true,
    },
    hints = {
        dictionary = "1234567890asdfg",
    }
})
vim.keymap.set("n", "<leader><leader>", function() require("snipe").open_buffer_menu() end)
