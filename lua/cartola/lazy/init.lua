return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        commit = "9504524e5ed0e326534698f637f9d038ba4cd0ee",
    },
    {
        "nvim-tree/nvim-web-devicons",
        commit = "2ae6958",
        lazy = true,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
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
        },
    },
    {
        "tpope/vim-fugitive",
        lazy = true,
        cmd = { "Git" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        enabled = false,
        lazy = true,
        event = "BufReadPost",
        opts = {},
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        enabled = false,
        lazy = true,
        event = "BufReadPost",
        opts = {
            enable_autocmd = false,
        },
    },
    {
        "andweeb/presence.nvim",
        enabled = false,
    },
    {
        "Carto1a/hexer.nvim",
        dir = "C:\\Users\\cepleite\\projetos\\hexer.nvim",
        dev = true,
        enabled = false,
        opts = {},
    },
    {
        "j-hui/fidget.nvim",
        enabled = false,
        lazy = true,
        event = { "LspAttach", "LspNotify", "LspProgress" },
        opts = {},
    },
}
