return {
    "folke/todo-comments.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim"
    },
    lazy = true,
    keys = { "<leader>tc" },
    cmd = { "TodoTrouble" },
    event = "BufRead",
    config = function()
        require("todo-comments").setup({})
        local open_menu = require("cartola.utils.util-trouble").open_menu;

        vim.keymap.set("n", "<leader>tc", function() open_menu("todo") end)
    end,
}
