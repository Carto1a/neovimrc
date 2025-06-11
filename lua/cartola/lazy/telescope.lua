return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>pf", require('telescope.builtin').find_files, desc = "telescope: [p]roject [f]iles" },
        { "<leader>pg", require('telescope.builtin').git_files, desc = "telescope: [p]roject [g]it files" },
        { "<leader>fb", require('telescope.builtin').buffers, desc = "telescope: [f]ind [b]uffers" },
        { "<leader>ps", function() require('telescope.builtin').grep_string({ search = vim.fn.input("Grep > ") }); end, desc = "telescope: [p]roject [s]earch (live grep)" }
    },
    lazy = true,
    event = { "VimEnter" },
    opts = {}
}
