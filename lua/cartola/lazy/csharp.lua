return {
    "Hoffs/omnisharp-extended-lsp.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    ft = { "cs" },
    lazy = true,
    config = function()
        local omnisharp = require("omnisharp_extended");

        local handlers = {
            ["textDocument/definition"] = omnisharp.definition_handler,
            ["textDocument/typeDefinition"] = omnisharp.type_definition_handler,
            ["textDocument/references"] = omnisharp.references_handler,
            ["textDocument/implementation"] = omnisharp.implementation_handler,
        }

        -- require('lspconfig').omnisharp.setup({ handlers = handlers })

        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
    end
}
