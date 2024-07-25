require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.adapters.gdb = {
    type = "executable",
    command = "gdb",
    args = { "-i", "dap" }
}

dap.configurations.c = {
    {
        name = "Launch",
        type ="gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.cpp = {
    {
        name = "Launch",
        type ="gdb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

dap.listeners.after.event_initalized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set("n", "<leader>b", ":DapToggleBreakpoint<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {buffer=0})

vim.keymap.set("n", "<F5>", "DapContinue<CR>")
vim.keymap.set("n", "<F10>", ":DapStepOver<CR>")
vim.keymap.set("n", "<F11>", ":DapStepInto<CR>")
vim.keymap.set("n", "<F12>", ":DapStepOut<CR>")

-- automatic installs
require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "delve", "debugpy" }
})
