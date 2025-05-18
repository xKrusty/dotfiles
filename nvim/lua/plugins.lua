return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/playground",
    "nvim-treesitter/nvim-treesitter-context",
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
    "numToStr/Comment.nvim",
    { "kylechui/nvim-surround", config = function() require("nvim-surround").setup({}) end},
    "leath-dub/snipe.nvim",

    -- lsp
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } },

    -- cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "onsails/lspkind.nvim",
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
    "luukvbaal/statuscol.nvim",
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },
    "HiPhish/rainbow-delimiters.nvim",
    -- "stevearc/dressing.nvim",
    "lewis6991/gitsigns.nvim",

    -- telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-telescope/telescope-fzf-native.nvim",
    "debugloop/telescope-undo.nvim",

    -- misc
    -- "dstein64/vim-startuptime",
    -- "ThePrimeagen/vim-be-good",
    -- "folke/which-key.nvim" -- in case i ever forget my keybinds

    -- local plugins
    {
        dir = "D:\\Coding\\Git\\dap_comp.nvim",
        name = "dap_comp",
    },
}
