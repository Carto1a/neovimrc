return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim"
	},
	config = function ()
		local todo = require("todo-comments").setup({})
		vim.keymap.set("n", "<leader>tc", ":TodoTrouble<cr>")
	end,
}
