return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        "hrsh7th/cmp-nvim-lsp-signature-help",
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
        "onsails/lspkind.nvim",
    },

    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    enabled = false,

    config = function()
        local cmp = require("cmp")

        local source_mapping = {
            nvim_lsp = "[LSP]",
            nvim_lua = "[LUA]",
            luasnip = "[SNIP]",
            buffer = "[BUF]",
            path = "[PATH]",
            treesitter = "[TREE]",
            ["vim-dadbod-completion"] = "[DB]",
            dap = "[DAP]",
        }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert({
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-n>'] = cmp.mapping.select_next_item({
                    behavior = cmp.ConfirmBehavior.Insert
                }),
                ["<C-p>"] = cmp.mapping.select_prev_item({
                    behavior = cmp.ConfirmBehavior.Insert
                }),
                ['<c-space>'] = cmp.mapping.complete(),
                ['<c-s>'] = cmp.mapping.complete(),
                ['<C-e>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),

            sources = cmp.config.sources({
                { name = 'nvim_lsp_signature_help' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
            }, {
                { name = 'buffer' },
                { name = 'path' },
            }),
            experimental = {
                ghost_text = true
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
                    kind.menu = "    " .. (strings[2] or "")

                    return kind
                end,
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            },
            matching = { disallow_symbol_nonprefix_matching = false }
        })

        cmp.setup.cmdline({ ':' }, {
            completion = {
                autocomplete = false
            },
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end
}
