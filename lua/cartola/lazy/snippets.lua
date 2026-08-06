return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
        commit = "6cd7280",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },
    tag = "v2.5.0",
    build = "make install_jsregexp",
    keys = {
        { mode = { "i" },      "<C-K>", function() require("luasnip").expand() end, desc = "luasnip: expand [K]ey (expand snippet)" },
        { mode = { "i", "s" }, "<C-L>", function() require("luasnip").jump(1) end,  desc = "luasnip: next entry" },
        { mode = { "i", "s" }, "<C-H>", function() require("luasnip").jump(-1) end, desc = "luasnip: previus entry" },
        {
            mode = { "i", "s" },
            "<C-E>",
            function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end,
            desc = "luasnip: next [E]xpandable choice"
        }
    },
    lazy = true
}
