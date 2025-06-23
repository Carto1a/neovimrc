return {
    'saghen/blink.cmp',
    build = 'cargo build --release',
    dependencies = {
        'L3MON4D3/LuaSnip'
    },

    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 2000,
            },
            ghost_text = {
                enabled = true
            },
            list = {
                selection = {
                    auto_insert = false
                }
            },
            menu = {
                draw = {
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'kind' } },
                    components = {
                        kind_icon = {
                            ellipsis = false,
                            text = function(ctx) return ctx.kind_icon .. ctx.icon_gap end,
                            highlight = function(ctx) return ctx.kind_hl end,
                        }
                    }
                }
            }
        },
        keymap = {
            preset = 'none',

            ['<C-b>'] = { 'scroll_documentation_down', 'fallback' },
            ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
            ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
            ["<C-p>"] = { 'select_prev', 'fallback_to_mappings' },
            ['<c-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<c-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ["<C-e>"] = { 'hide' },
            ['<CR>'] = { 'accept', 'fallback' },
        },
        signature = {
            enabled = true
        },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono'
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
        },
        fuzzy = { implementation = "rust" },
        snippets = { preset = 'luasnip' },

        cmdline = {
            enabled = true,
            keymap = {
                preset = 'none',

                ['<C-b>'] = { 'scroll_documentation_down', 'fallback' },
                ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
                ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
                ['<C-n>'] = { 'select_next', 'fallback_to_mappings' },
                ["<C-p>"] = { 'select_prev', 'fallback_to_mappings' },
                ['<c-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<tab>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ['<c-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
                ["<C-e>"] = { 'hide' },
                ['<CR>'] = { 'accept', 'fallback' },
            },
            completion = {
                menu = {
                    auto_show = false
                },
                ghost_text = {
                    enabled = true
                },
                list = {
                    selection = {
                        auto_insert = false,
                        preselect = false
                    }
                }
            },
        }
    }
}
