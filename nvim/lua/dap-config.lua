local dap, dapui = require("dap"), require("dapui")

dapui.setup()

-- adapters
dap.adapters.python = function(cb, config)
    if config.request == "attach" then
      ---@diagnostic disable-next-line: undefined-field
      local port = (config.connect or config).port
      ---@diagnostic disable-next-line: undefined-field
      local host = (config.connect or config).host or "127.0.0.1"
      cb({
        type = "server",
        port = assert(port, "`connect.port` is required for a python `attach` configuration"),
        host = host,
        options = {
          source_filetype = "python",
        },
      })
    else
      cb({
        type = "executable",
        command = "C:\\Program Files\\Python311\\pythonw.exe",
        args = { "-m", "debugpy.adapter" },
        options = {
          source_filetype = "python",
        },
      })
    end
  end

dap.adapters.cpptools = {
    type = "executable",
    command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7.cmd',
    args = {},
    options = {
        detached = false
    }
}

-- configurations
dap.configurations.c = {
    {
        name = "Launch",
        type ="cpptools",
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
        type ="cpptools",
        request = "launch",
        program = function()
            return vim.fn.input("Path to exe: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
    },
}

dap.configurations.python = {
    {
        type = "python",
        request = "launch",
        name = "Launch File",
        program = "${file}",
        pythonPath = function()
            local venv = vim.env.virtual_env
            if venv == nil then
                venv = "venv"
            end
            if vim.fn.executable(venv .. "/Scripts/pythonw.exe") == 1 then -- windows
                return venv .. "/Scripts/pythonw.exe"
            elseif vim.fn.executable(venv .. "/bin/python.exe") == 1 then -- linux
                return venv .. "/bin/python.exe"
            elseif vim.fn.executable("pythonw.exe") == 1 then
                return "pythonw.exe"
            else
                return "python"
            end
        end,
    },
}

-- dap ui
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.after.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.after.event_exited["dapui_config"] = function()
    dapui.close()
end

-- keymap
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {buffer=0})

vim.keymap.set("n", "<leader>i", function() dapui.eval(nil, { enter = true }) end) -- inspect value under cursor

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F10>",dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<S-F5>", dap.step_back)

-- automatic installs
require("mason").setup()
require("mason-nvim-dap").setup({
    ensure_installed = { "delve", "debugpy", "cpptools" },
    automatic_installation = false,
    -- handlers = {
    --     function(config)
    --         require("mason-nvim-dap").default_setup(config)
    --     end,
    -- }
})
