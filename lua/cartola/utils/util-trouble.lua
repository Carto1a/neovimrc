M = {}

local trouble = require("trouble")
local last_mode = "diagnostics_buffer"

function M.open_menu(mode)
    print(mode)
    if mode == nil then
        trouble.toggle(last_mode)
        return
    end

    last_mode = mode
    trouble.toggle(mode)
end

return M
