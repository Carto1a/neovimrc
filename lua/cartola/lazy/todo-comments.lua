return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim"
    },
    lazy = true,
    keys = {
        { "<leader>tc", function() require("cartola.utils.util-trouble").open_menu("todo") end, desc = "trouble: commentaries" }
    },
    cmd = "TodoTrouble",
    event = "BufRead",
    opts = {}
}
