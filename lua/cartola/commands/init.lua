require("cartola.commands.godot")
require("cartola.commands.vimcfg")

vim.api.nvim_create_user_command('Balatro', function()
    vim.fn.jobstart({ "steam", "steam://rungameid/2379780" }, { detach = true })
end, {})
