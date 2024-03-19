return {
	-- colorshemes
	{ "sainnhe/gruvbox-material", priority = 1000 },
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },
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
	"mbbill/undotree",
}
