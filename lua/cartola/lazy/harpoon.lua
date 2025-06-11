---@type Harpoon
local harpoon = nil

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
    keys = {
        { "<leader>a", function() harpoon:list():add() end,                         desc = "harpoon: [a]ppend file to list" },
        { "<C-e>",     function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon: toggle [e]ntry menu" },
        { "<C-p>",     function() harpoon:list():prev() end,                        desc = "harpoon: go to [p]revious file" },
        { "<C-n>",     function() harpoon:list():next() end,                        desc = "harpoon: go to [n]ext file" },
    },
    opts = {
        settings = {
            save_on_toggle = true,
        },
    },
    config = function(_, opts)
        harpoon = require("harpoon")
        harpoon:setup(opts)
    end
}
