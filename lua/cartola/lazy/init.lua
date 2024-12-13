return {
    {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose-pine"
    },
    "nvim-tree/nvim-web-devicons",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        lazy = true,
        event = "BufReadPre",
        opts = {
            indent = {
                char = { "▎" },
                tab_char = "▎",
            },
            scope = {
                enabled = false,
            },
        }
    },
    {
        "tpope/vim-fugitive",
        lazy = true,
        cmd = { "Git" }
    },
    -- {
    --     "tpope/vim-commentary",

    --     -- TODO: veficar todas as keys
    --     -- keys = { "gc" }
    -- },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = "BufRead"

    },
    {
        "williamboman/mason.nvim",
        lazy = true,
        cmd = "Mason",
        opts = {}
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        opts = {
            enable_autocmd = false
        },
        lazy = true,
        event = "BufReadPre",
    }
}
