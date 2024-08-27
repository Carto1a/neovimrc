return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        --'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "onsails/lspkind.nvim"
    },

    config = function()
        require("fidget").setup({})
        require("mason").setup()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        local lspconfig = require("lspconfig")

        vim.diagnostic.config({
            virtual_text = true,
            signs = true,
            underline = false,
            update_in_insert = false,
            severity_sort = false,
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "omnisharp",
                "zls",
            },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({})
                end,

                ["omnisharp"] = function()
                    lspconfig.omnisharp.setup({
                        enable_roslyn_analyzers = true,
                        organize_imports_on_format = true,
                        enable_import_completion = true,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim" }
                                },
                                hint = {
                                    enable = true
                                }
                            }
                        }
                    })
                end
            }
        })
        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-n>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item()
                    end
                end),
                ["<C-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    end
                end),
                ['<C-Space>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'nvim_lsp_signature_help' },
            }, {
                { name = 'buffer' },
            }),
            experimental = {
                ghost_text = false
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"

                    return kind
                end,
            },
        })
        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            }
        })
    end
}
