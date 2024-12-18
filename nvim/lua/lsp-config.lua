
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
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.hover() end, opts)
end)

-- automatic installs
require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = { "clangd", "texlab", "basedpyright", "gopls", "ols" },
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
    }
})

require("lspconfig").basedpyright.setup({
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
            }
        }
    }
})

require("lspconfig").ols.setup({
    settings = {
        enable_hover = true,
        enable_snippets = true,
        enable_references = true,
    }
})
