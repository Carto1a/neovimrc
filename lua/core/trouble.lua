local M = {
    last_mode = "diagnostics_buffer"
}

function M.open_menu(mode)
    local trouble = require("trouble")
    if mode == nil then
        trouble.toggle(M.last_mode)
        return
    end

    M.last_mode = mode
    trouble.toggle(mode)
end

return M
