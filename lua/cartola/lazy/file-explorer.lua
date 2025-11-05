return {
    "tamago324/lir.nvim",
    dependencies = {
        'nvim-lua/plenary.nvim',
        "nvim-tree/nvim-web-devicons"
    },

    pin = true,
    commit = "7a9d45d",

    opts = function()
        local actions = require('lir.actions')
        local mark_actions = require('lir.mark.actions')
        local clipboard_actions = require('lir.clipboard.actions')

        local mappings = {
            ['l']     = actions.edit,
            ['h']     = actions.up,

            ['<cr>']  = actions.edit,

            ['<C-s>'] = actions.split,
            ['<C-v>'] = actions.vsplit,
            ['<C-t>'] = actions.tabedit,

            ['q']     = actions.quit,

            ['K']     = actions.mkdir,
            ['N']     = actions.newfile,
            ['R']     = actions.rename,
            ['@']     = actions.cd,
            ['Y']     = actions.yank_path,
            ['.']     = actions.toggle_show_hidden,
            ['D']     = actions.delete,

            ['J']     = function()
                mark_actions.toggle_mark()
                vim.api.nvim_feedkeys('j', 'n', false)
            end,
            ['C']     = clipboard_actions.copy,
            ['X']     = clipboard_actions.cut,
            ['P']     = clipboard_actions.paste,
        }
        return {
            show_hidden_files = false,
            ignore = {}, -- { ".DS_Store", "node_modules" } etc.
            devicons = {
                enable = true,
                highlight_dirname = true
            },
            mappings = mappings,
            float = {
                winblend = 0,
                curdir_window = {
                    enable = false,
                    highlight_dirname = false
                },
            },
            hide_cursor = true
        }
    end,

    config = function(_, opts)
        require("lir").setup(opts)
        local float = require('lir.float')

        local map = vim.keymap.set
        map("n", "<leader>pv", function()
            float.toggle(vim.uv.cwd())
        end)
    end
}
