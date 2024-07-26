return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
    "akinsho/bufferline.nvim",
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
    "numToStr/Comment.nvim",
    "petertriho/nvim-scrollbar",
    "nvim-treesitter/playground",

    -- lsp
    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    { "williamboman/mason-lspconfig.nvim", dependencies = { "williamboman/mason.nvim" } }, 

    -- cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "onsails/lspkind.nvim",

    -- dap
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    { "jay-babu/mason-nvim-dap.nvim", dependencies = { "williamboman/mason.nvim"} },

    -- themes
    { "rose-pine/neovim", name = "rose-pine" },

    -- telescope
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "nvim-telescope/telescope-fzf-native.nvim",

}

