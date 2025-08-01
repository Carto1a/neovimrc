return {
    {
        "rose-pine/neovim",
        priority = 1000,
        name = "rose-pine"
    },
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
        lazy = true
    },
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
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = true,
        event = "BufReadPost",
        opts = {}
    },
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        event = "BufReadPost",
        opts = {
            enable_autocmd = false
        },
    },
    {
        'andweeb/presence.nvim',
        enabled = false
    },
    {
        "Carto1a/hexer.nvim",
        dir = "C:\\Users\\cepleite\\projetos\\hexer.nvim",
        dev = true,
        enabled = false,
        opts = {}
    },
    {
        "j-hui/fidget.nvim",
        lazy = true,
        event = { "LspAttach", "LspNotify", "LspProgress" },
        opts = {}
    }
}
