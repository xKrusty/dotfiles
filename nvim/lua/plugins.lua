return {
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    "nvim-treesitter/playground",
    "nvim-telescope/telescope.nvim",
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", opt = true } },
    "akinsho/bufferline.nvim",
    { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end },
    "numToStr/Comment.nvim",
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
    "petertriho/nvim-scrollbar",

    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",

    { "rose-pine/neovim", name = "rose-pine" }
}

