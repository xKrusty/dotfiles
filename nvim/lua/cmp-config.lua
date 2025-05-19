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
            local highlights_info = require("colorful-menu").cmp_highlights(entry)
            if highlights_info ~= nil then
                vim_item.abbr_hl_group = highlights_info.highlights
                vim_item.abbr = highlights_info.text
            end

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
    enabled = true,
})

cmp.setup.filetype({ "dap-repl", "dapui-watches", "dapui_hover" }, { -- autocomplete for repl, is a bit bugged
    sources = {
        { name = "dap" },
    },
})
