vim.g.PROFILE = "cartola"

require("core.custom.project_config")
require("cartola.set")
require("cartola.auto")
require("cartola.maps")
require("cartola.lazy_init")
require("cartola.lsp")
require("core.commands")

vim.cmd.colorscheme("rose-pine-main")

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end

vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.g.PATH.NVIM_CONFIG .. "/lua/cartola/runtime"
