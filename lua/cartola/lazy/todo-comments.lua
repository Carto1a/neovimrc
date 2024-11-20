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
        local todo = require("todo-comments").setup({})
        vim.keymap.set("n", "<leader>tc", "<cmd>TodoTrouble<cr>")
    end,
}
