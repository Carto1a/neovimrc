return {
    "mbbill/undotree",
    lazy = true,
    cmd = { "UndotreeToggle", "UndotreeShow" },
    keys = { "<leader>u" },

    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    end
}
