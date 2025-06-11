return {
    "mbbill/undotree",
    lazy = true,
    tag = 'rel_6.1',
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "[u]ndotree: toggle" }
    },
    init = function()
        vim.g.undotree_SetFocusWhenToggle = true
    end
}
