return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
    },

    opts = function(_, opts)

--         local registry = require("mason-registry")
--         if not registry.is_installed("vue-language-server") then
--             return
--         end
--         -- registry.refresh(function ()
--      -- registry.get_package("vue-language-server")
-- -- end)
--         local vue_typescript_plugin = registry
--             .has_package("vue-language-server")

--         local t = registry.get_installed_packages()
--         for k, v in pairs(t) do
--             -- local p = registry.has_package(v)
--             print(k, v)
--         end

--             -- :get_install_path()
--             --     .. "/node_modules/@vue/language-server"
--             --     .. "/node_modules/@vue/typescript-plugin"

--     -- opts.servers = vim.tbl_deep_extend("force", opts.servers, {
--     --   volar = {},
--     --   -- Volar 2.0 has discontinued their "take over mode" which in previous version provided support for typescript in vue files.
--     --   -- The new approach to get typescript support involves using the typescript language server along side volar.
--     --   tsserver = {
--     --     init_options = {
--     --       plugins = {
--     --         -- Use typescript language server along with vue typescript plugin
--     --         {
--     --           name = "@vue/typescript-plugin",
--     --           location = vue_typescript_plugin,
--     --           languages = { "javascript", "typescript", "vue" },
--     --         },
--     --       },
--     --     },
--     --     filetypes = {
--     --       "javascript",
--     --       "javascriptreact",
--     --       "javascript.jsx",
--     --       "typescript",
--     --       "typescriptreact",
--     --       "typescript.tsx",
--     --       "vue",
--     --     },
--     --   },
--     -- })
    end,
}
