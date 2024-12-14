require("cartola.set")
require("cartola.auto")
require("cartola.remap")
require("cartola.netrw")
require("cartola.lazy_init")
require("cartola.utils.util-godot")

vim.cmd.colorscheme("rose-pine-main")

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end
