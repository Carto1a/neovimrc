return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = false,
    enabled = false,
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "query",
            "java",
            "javascript",
            "typescript",
            "zig",
            "go",
            "c_sharp",
        },

        sync_install = false,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
    config = function(_, opts)
        require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }
        require('nvim-treesitter.configs').setup(opts)
    end
}
