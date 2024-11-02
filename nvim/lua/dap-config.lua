local dap, dapui = require("dap"), require("dapui")


-- ================
-- odin configuration
-- ================
dap.adapters.lldb = {
    type = "executable",
    command = "lldb-vscode",
    name = "lldb"
}

dap.configurations.odin = {
    {
        name = "Debug",
        type = "lldb",
        request = "launch",
        program = vim.fn.getcwd():match("([^/\\]+)$") .. ".exe",
        cwd = "${workspaceFolder}",
        preLaunchTask = function()
            local handle = io.popen("odin build . -debug")
            local result = handle:read("a")
            handle:close()

            if string.find(result, "Error") then -- exit when compilation failed
                dap.terminate()
            end
        end
    }
}


-- ================
-- go configuration
-- ================
dap.adapters.go = function(cb, config)
    local port = (config.connect or config).port
    local host = (config.connect or config).host or "127.0.0.1"

    cb({
        type = "server", 
        port = assert(port, "`connect.port` is required for go"),
        host = host,
        executable = {
            command = "dlv",
            args = { "dap", "-l", host .. ":" .. port },
            detached = false,
            cwd = vim.fn.getcwd(),
        },
        option = {
            initialize_timeout_sec = 10,
        },
    })
end

dap.configurations.go = {
    {
        name = "Debug",
        type = "go",
        request = "launch",
        program = "${file}",
        -- program = function()
        --     root = vim.fn.getcwd():match("([^/\\]+)$")
        --     return root
        -- end,
        connect = {
            port = "5678",
        },
        justMyCode = false,
    }
}


-- ===================
-- C/C++ Configuration
-- ===================
dap.adapters.cpptools = {
    type = "executable",
    command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7.cmd',
    args = {},
    options = {
        detached = false
    }
}

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

-- ====================
-- Python Configuration
-- ====================
dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        local port = (config.connect or config).port
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

local function get_python_interpreter()
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
end

local debugpy_id = nil -- ID to keep track of debugpy server process
local function start_debugpy_server(file)
    local interpreter = get_python_interpreter()
    local cmd = { interpreter, "-m", "debugpy", "--listen", "5678", "--wait-for-client", file }
    debugpy_id = vim.fn.jobstart(cmd)
    vim.print("Debugpy server started: " .. debugpy_id .. ", " .. file)
end

local function stop_debugpy_server()
    if debugpy_id then
        vim.fn.jobstop(debugpy_id)
        debugpy_id = nil
        vim.print("Debugpy server stopped")
    end
end

-- use attach, to fix an error which stops the debugging process in Python (WARN: No event handler for ... event = "debugpyAttach"), also seems to be overall faster :)
dap.configurations.python = {
    {
        type = "python",
        request = "attach",
        -- request = "launch",
        name = "Attach File to Server",
        program = "${file}",
        console = "integratedTerminal", -- doesnt seem to use the dap Terminal, just outputs into nothing?
        redirectOutput = true,
        pythonPath = get_python_interpreter,
        connect = {
            port = "5678",
        },
        preLaunchTask = function()
            start_debugpy_server(vim.fn.expand("%")) -- get current buffer file
        end,
        --postDebugTask = stop_debugpy_server, -- doenst work?, seems to be called right after preLaunchTask, before i event start debugging
    },
    {
        type = "python",
        request = "launch",
        name = "Launch File with Args",
        program = "${file}",
        pythonPath = get_python_interpreter,
        -- args = function()
        --     local input = vim.fn.input("Arguments: ")
        --     return vim.split(input, " ", { trimempty = true } )
        -- end,
        args = function()
            local co = coroutine.running()
            local cb = function(input)
                coroutine.resume(co, input)
            end
            
            cb = vim.schedule_wrap(cb)
            if vim.ui then
                vim.ui.input({prompt = "Arguments: " }, cb)

                local input = coroutine.yield()
                return vim.split(input, " ", { triempty = true } )
            else
                local input = vim.fn.input("Arguments: ")
                return vim.split(input, " ", { trimempty = true } )
            end

            if co then
            end
        end,
    },
}

-- register Event listener to stop Debugpy
dap.listeners.after.event_terminated.stop_debugpy = stop_debugpy_server
dap.listeners.after.event_exited.stop_debugpy = stop_debugpy_server


-- ====================
-- dap ui configuration
-- ====================
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
vim.keymap.set("n", "<leader>gc", dap.clear_breakpoints)
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {buffer=0})

vim.keymap.set("n", "<leader>i", function() dapui.eval(nil, { enter = true }) end) -- inspect value under cursor

vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.pause)
vim.keymap.set("n", "<F7>", dap.restart)
vim.keymap.set("n", "<F10>",dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F12>", dap.step_out)
vim.keymap.set("n", "<S-F5>", ":lua require'dap'.disconnect({terminateDebuggee = true})<CR>")

-- dap ui
dapui.setup({
    controls = {
      element = "repl",
      enabled = true,
      icons = {
        disconnect = "",
        pause = "",
        play = "",
        run_last = "",
        step_back = "",
        step_into = "",
        step_out = "",
        step_over = "",
        terminate = ""
      }
    },
    element_mappings = {},
    expand_lines = true,
    floating = {
      border = "single",
      mappings = {
        close = { "q", "<Esc>" }
      }
    },
    force_buffers = true,
    icons = {
      collapsed = "",
      current_frame = "",
      expanded = ""
    },
    layouts = { {
        elements = { {
            id = "scopes",
            size = 0.25
          }, {
            id = "breakpoints",
            size = 0.25
          }, {
            id = "stacks",
            size = 0.25
          }, {
            id = "watches",
            size = 0.25
          } },
        position = "left",
        size = 40
      }, {
        elements = { {
            id = "repl",
            size = 1
          } },
        position = "bottom",
        size = 20
      } },
    mappings = {
      edit = "e",
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      repl = "r",
      toggle = "t"
    },
    render = {
      indent = 1,
      max_value_lines = 100
    }
})

-- ========================
-- Additional configuration
-- ========================

--require("nvim-dap-virtual-text").setup()

-- -- automatic installs
-- require("mason").setup()
-- require("mason-nvim-dap").setup({
--     ensure_installed = { "delve", "debugpy", "cpptools" },
--     automatic_installation = false,
--     -- handlers = {
--     --     function(config)
--     --         require("mason-nvim-dap").default_setup(config)
--     --     end,
--     -- }
-- })

-- hide REPL buffer
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "dap-repl",
--     callback = function(args)
--         vim.api.nvim_buf_set_option(args.buf, "buflisted", false)
--     end,
-- })
