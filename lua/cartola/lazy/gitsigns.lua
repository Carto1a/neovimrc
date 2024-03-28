return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require('gitsigns').setup({
            numhl = true,
            current_line_blame = false,
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'right_align',
                delay = 50,
            },
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
                    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
                end

                -- -- Navigation
                -- map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
                -- map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

                -- Actions
                map('n', '<leader>Ghs', ':Gitsigns stage_hunk<CR>')
                map('v', '<leader>Ghs', ':Gitsigns stage_hunk<CR>')
                map('n', '<leader>Ghr', ':Gitsigns reset_hunk<CR>')
                map('v', '<leader>Ghr', ':Gitsigns reset_hunk<CR>')
                map('n', '<leader>GhS', '<cmd>Gitsigns stage_buffer<CR>')
                map('n', '<leader>Ghu', '<cmd>Gitsigns undo_stage_hunk<CR>')
                map('n', '<leader>GhR', '<cmd>Gitsigns reset_buffer<CR>')
                map('n', '<leader>Ghp', '<cmd>Gitsigns preview_hunk<CR>')
                map('n', '<leader>Ghb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
                map('n', '<leader>Gtb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
                map('n', '<leader>Ghd', '<cmd>Gitsigns diffthis<CR>')
                map('n', '<leader>GhD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
                map('n', '<leader>Gtd', '<cmd>Gitsigns toggle_deleted<CR>')

                -- -- Text object
                -- map('o', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                -- map('x', 'ih', ':<C-U>Gitsigns select_hunk<CR>')
            end
        })
    end

}
