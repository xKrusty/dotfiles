local builtin = require("statuscol.builtin")
require("statuscol").setup({
    relculright = true, -- right-align the cursor line number with "relativenumber"
    segments = {
        { sign = { name = { ".*" }, maxwidth = 1, auto = false }, click = "v:lua.ScSa" }, -- Breakpoint
        { text = { builtin.lnumfunc }, click = "v:lua.ScSa" }, -- line number
        { text = { builtin.foldfunc }, click = "v:lua.ScFa" }, -- folds
        { text = { " " } } -- padding to prevent folds-sign from overlapping into text
    }
})
-- set Debugging icons, colors found in :hi
vim.fn.sign_define("DapBreakpoint", { text="", texthl="DapUIStop", linehl="", numhl="" })
vim.fn.sign_define("DapBreakpointCondition", { text="", texthl="DapUIStop", linehl="", numhl="" })
vim.fn.sign_define("DapStopped", { text="", texthl="DapUIPlayPause", linehl="", numhl="" })

require("ufo").setup({})
require("ibl").setup({
    scope = { enabled = false }
})

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

