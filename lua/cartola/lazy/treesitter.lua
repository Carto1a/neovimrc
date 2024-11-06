return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    lazy = true,
    event = "BufRead",
    config = function()
        require('nvim-treesitter.install').compilers = { 'clang', 'gcc' }
        require('nvim-treesitter.configs').setup({
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
        })
    end
}
