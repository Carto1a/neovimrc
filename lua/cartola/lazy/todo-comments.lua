local open_menu = require("core.trouble").open_menu

return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim"
    },
    lazy = true,
    keys = {
        { "<leader>tc", function() open_menu("todo") end, desc = "trouble: commentaries" }
    },
    cmd = "TodoTrouble",
    event = "BufRead",
    opts = {}
}
