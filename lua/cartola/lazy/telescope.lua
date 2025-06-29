return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    lazy = true,
    event = { "VimEnter" },
    opts = {},
    config = function()
        vim.keymap.set("n", "<leader>pf", require('telescope.builtin').find_files, {})
        vim.keymap.set("n", "<leader>pg", require('telescope.builtin').git_files, {})
        vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers, {})
        vim.keymap.set("n", "<leader>ps", function()
            require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") })
        end, {})
    end
}
