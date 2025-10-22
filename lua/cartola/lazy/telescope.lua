return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    keys = {
        { "<leader>pf", function() require('telescope.builtin').find_files() end, desc = "telescope: [p]roject [f]iles" },
        { "<leader>pg", function() require('telescope.builtin').git_files() end,  desc = "telescope: [p]roject [g]it files" },
        { "<leader>fb", function() require('telescope.builtin').buffers() end,    desc = "telescope: [f]ind [b]uffers" },
        { "<leader>ps", function() require('telescope.builtin').live_grep(); end, desc = "telescope: [p]roject [s]earch (live grep)" } },
    lazy = true,
    opts = {}
}
