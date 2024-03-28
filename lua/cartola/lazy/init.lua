return {
    { "rose-pine/neovim",         priority = 1000, name = "rose-pine" },
    { "sainnhe/gruvbox-material", priority = 1000 },
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    "github/copilot.vim",
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
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
    "tpope/vim-fugitive",
    "tpope/vim-commentary",
    "nvim-treesitter/nvim-treesitter-context",
}
