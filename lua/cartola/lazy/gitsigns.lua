return {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufRead" },
    opts = {
        numhl = true,
        current_line_blame = false,
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'right_align',
            delay = 50,
        },
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, noremap = true, silent = true })
            end

            -- Navigation
            map('n', ']c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    gitsigns.nav_hunk('next')
                end
            end, "gitsigns: next [c]hange")

            map('n', '[c', function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    gitsigns.nav_hunk('prev')
                end
            end, "gitsigns: previous [c]hange")

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk, "gitsigns: [h]unk [s]tage")
            map('n', '<leader>hr', gitsigns.reset_hunk, "gitsigns: [h]unk [r]eset")

            map('v', '<leader>hs', function() gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "gitsigns: [h]unk [s]tage (visual)")
            map('v', '<leader>hr', function() gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, "gitsigns: [h]unk [r]eset (visual)")

            map('n', '<leader>hS', gitsigns.stage_buffer, "gitsigns: [h]unks [S]tage entire buffer")
            map('n', '<leader>hR', gitsigns.reset_buffer, "gitsigns: [h]unks [R]eset entire buffer")

            map('n', '<leader>hp', gitsigns.preview_hunk, "gitsigns: [h]unks [p]review")
            map('n', '<leader>hi', gitsigns.preview_hunk_inline, "gitsigns: [h]unk preview [i]nline")

            map('n', '<leader>hb', function()
                gitsigns.blame_line({ full = true })
            end, "gitsigns: [h]unk [b]lame current line")

            map('n', '<leader>hd', gitsigns.diffthis, "gitsigns: [h]unks [d]iff")
            map('n', '<leader>hD', function()
                gitsigns.diffthis('~')
            end, "gitsigns: [h]unks [D]iff")

            map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, "gitsigns: all [h]unks to [Q]uickfix")
            map('n', '<leader>hq', gitsigns.setqflist, "gitsigns: [h]unks to [q]uickfix")

            -- Toggles
            map('n', '<leader>gtb', gitsigns.toggle_current_line_blame, "[g]itsigns: [t]oggle current line [b]leme")
            map('n', '<leader>gtw', gitsigns.toggle_word_diff, "[g]itsigns: [t]oggle [w]ord diff")

            -- Text object
            map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end
    }
}
