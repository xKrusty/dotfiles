require('gitsigns').setup()

require("scrollbar").setup({
    show = true,
    show_in_active_only = false,
    set_highlights = true,
    handle = {
        text = " ",
        blend = 30,
        color = nil,
        color_nr = nil,
        highlight = "CursorColumn",
        hide_if_all_visible = true,
    },
    marks = {
        Cursor = {
            text = " ",
        }
    }
})
-- require("scrollbar.handlers.gitsigns").setup()
