return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/playground",
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
    "numToStr/Comment.nvim",
    { "kylechui/nvim-surround", config = function() require("nvim-surround").setup({}) end },
    "leath-dub/snipe.nvim",
    { "rmagatti/auto-session", config = function() require("auto-session").setup({}) end },
    { "folke/todo-comments.nvim", config = function() require("todo-comments").setup({ highlight = { multiline = false, keyword = "fg", after = "" } }) vim.api.nvim_create_user_command("Todo", "TodoTelescope", {}) end },
    { "echasnovski/mini.files", config =
        function()
            require("mini.files").setup({
                options = { permanent_delete = false },
                content = {
                    filter = function(entry)
                        return not vim.startswith(entry.name, '.')
                    end,
                },
            })
            vim.keymap.set("n", "<leader>e", MiniFiles.open, {})
        end
    },
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      opts = {},
      keys = {
        { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
        { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
        -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
        -- { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        -- { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
    },


    -- lsp
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },

    -- cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim", -- adds icon to autocomplete entries
    { "xzbdmw/colorful-menu.nvim", config = function() require("colorful-menu").setup({}) end }, -- colors autocomplete entries
    "rcarriga/cmp-dap", -- autocomplete for dap-repl
    "0n3W4y7ick3t/cmp-nvim-lsp-signature-help", -- fork, has proper highlighting

    -- dap
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, command = "DapContinue" },
    { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim"} },
    -- "theHamsta/nvim-dap-virtual-text",

    -- looks / themes
    { "rose-pine/neovim", name = "rose-pine" },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
    "akinsho/bufferline.nvim",
    "petertriho/nvim-scrollbar",
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async", "luukvbaal/statuscol.nvim" } },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    "HiPhish/rainbow-delimiters.nvim",
    "lewis6991/gitsigns.nvim",
    { "OXY2DEV/helpview.nvim", config = function() require("helpview").setup({ preview = { icon_provider = "devicons" } }) end },
    "nvim-treesitter/nvim-treesitter-context", -- show current function/struct (and such) youre in

    -- telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-telescope/telescope-fzf-native.nvim",
    "debugloop/telescope-undo.nvim",

    -- misc
    -- "dstein64/vim-startuptime",
    -- "ThePrimeagen/vim-be-good",
    -- "folke/which-key.nvim" -- in case i ever forget my keybinds
}
