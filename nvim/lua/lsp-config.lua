local lspconfig = require("lspconfig")
local lsp = require("lsp-zero")

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
    lsp.preset("recommended")

    local opts= {buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
                                            local success, telescope = pcall(require, "telescope.builtin")
                                            if success then
                                                telescope.lsp_references()
                                            else
                                                vim.lsp.buf.references()
                                            end
                                        end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)

    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
end)

-- automatic installs
require("mason").setup({})
-- require("mason-lspconfig").setup({
--     ensure_installed = { "texlab", "basedpyright", "ols", "biome" },
--     handlers = {
--         function(server_name)
--             -- require("lspconfig")[server_name].setup({})
--         end,
--     }
-- })

lspconfig.basedpyright.setup({
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            }
        }
    }
})

lspconfig.ols.setup({
    settings = {
        enable_hover = true,
        enable_snippets = true,
        enable_references = true,
    }
})

lspconfig.biome.setup({
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
    end,
})


lspconfig.zls.setup({
    settings = {
        zls = {
            enable_build_on_save = false,
        },
        enable_build_on_save = false,
    }
})
vim.g.zig_fmt_autosave=0

lspconfig.gdscript.setup{

}

lspconfig.gopls.setup({
    on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = false })
            end,
        })
    end,
})

-- lua =require("mason-lspconfig").get_available_servers()
lspconfig.cssls.setup({})
lspconfig.html.setup({})
lspconfig.lua_ls.setup({})
lspconfig.omnisharp.setup({})
lspconfig.texlab.setup({})
lspconfig.denols.setup({})

