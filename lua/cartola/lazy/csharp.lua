return {
    "Hoffs/omnisharp-extended-lsp.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    ft = { "cs" },
    config = function()
        local omnisharp = require("omnisharp_extended");

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    end
}
