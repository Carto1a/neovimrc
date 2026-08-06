return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function(_, _)
        require("nvim-treesitter")
            .install({
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
            })
            :wait(300000)
        require("nvim-treesitter").setup()
    end,
}
