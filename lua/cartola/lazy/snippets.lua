return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets"
    },
    version = "v2.3.0",
    build = "make install_jsregexp",
    config = function()
        local luaSnip = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load()

        vim.keymap.set({ "i" }, "<C-K>", function() luaSnip.expand() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-L>", function() luaSnip.jump(1) end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<C-H>", function() luaSnip.jump(-1) end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-E>", function()
            if luaSnip.choice_active() then
                luaSnip.change_choice(1)
            end
        end, { silent = true })
    end
}
