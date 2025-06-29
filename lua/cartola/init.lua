require("cartola.utils").load_env_file(vim.g.NVIM_CONFIG .. "/lua/cartola" .. "/.env")
require("cartola.set")
require("cartola.auto")
require("cartola.maps")
require("cartola.lazy_init")
require("cartola.utils.util-godot")
require("cartola.utils.util-commands")
require("cartola.lsp")

vim.cmd.colorscheme("rose-pine-main")

local get_option = vim.filetype.get_option
vim.filetype.get_option = function(filetype, option)
    return option == "commentstring"
        and require("ts_context_commentstring.internal").calculate_commentstring()
        or get_option(filetype, option)
end

vim.g.PROFILE = "cartola"
vim.o.runtimepath = vim.o.runtimepath .. "," .. vim.g.NVIM_CONFIG .. "/lua/cartola/runtime"

print(vim.g.ENV.TESTE)
