return {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "[u]ndotree: toggle" }
    },
    config = function()
        vim.g.undotree_SetFocusWhenToggle = true
    end
}
