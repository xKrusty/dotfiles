local builtin = require("statuscol.builtin")
require("statuscol").setup({
    relculright = true, -- right-align the cursor line number with "relativenumber"
    segments = {
        --{ text = { "%s" } }, -- Breakpoint
        { text = { builtin.lnumfunc }, click = "v:lua.ScSa" }, -- line number
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" }, -- folds
        { sign = { name = "padding", colwidth = 1, fillchar = " "} } -- padding to prevent folds-sign from overlapping into text
    }
    
})

require("ufo").setup({})
require("ibl").setup({
    scope = { enabled = false }
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

