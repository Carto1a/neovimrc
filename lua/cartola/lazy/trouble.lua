return {
	"folke/trouble.nvim",
	config = function()
		local setmap = vim.keymap.set
		local trouble = require("trouble")
		trouble.setup({
			icons = false,
		})

		setmap("n", "<leader>tt", function() trouble.toggle() end)
		setmap("n", "<leader>tw", function() trouble.toggle("workspace_diagnostics") end)
		setmap("n", "<leader>td", function() trouble.toggle("document_diagnostics") end)
		setmap("n", "<leader>tq", function() trouble.toggle("quickfix") end)
		setmap("n", "<leader>tl", function() trouble.toggle("loclist") end)
		setmap("n", "<leader>[t", function() trouble.next({ skip_groups = true, jump = true }) end)
		setmap("n", "<leader>]t", function() trouble.previous({ skip_groups = true, jump = true }) end)
		setmap("n", "gr", function() trouble.toggle("lsp_references") end)
		setmap("n", "gd", function() trouble.toggle("lsp_definitions") end)
		setmap("n", "gi", function() trouble.toggle("lsp_implementations") end)
	end,
}
