local cmp = require("cmp")

cmp.setup({
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "nvim_lsp_signature_help" },
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping.close()
    },
    formatting = {
        format = function(entry, vim_item)
            return require("lspkind").cmp_format({ with_text = true })(entry, vim_item)
        end
    },
    window = {
        completion = {
            border = "rounded"
        },
        documentation = {
            border = "rounded"
        }
    },
    enabled = function() -- for dap-repl autocomplete
        return vim.api.nvim_buf_get_option(0, "buftype") == "prompt"
            or require("cmp_dap").is_dap_buffer()
        end,
})

cmp.setup.filetype({ "dap-repl", "dapui-watches", "dapui_hover" }, { -- autocomplete for repl, is a bit bugged
    sources = {
        { name = "dap" },
    },
})
