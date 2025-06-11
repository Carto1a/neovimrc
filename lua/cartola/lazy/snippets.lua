return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
            -- require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end
    },
    tag = "v2.3.0",
    build = "make install_jsregexp",
    keys = {
        { mode = { "i" },      "<C-K>", require("luasnip").expand,                  desc = "luasnip: expand [K]ey (expand snippet)" },
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
    opts = {}
}
