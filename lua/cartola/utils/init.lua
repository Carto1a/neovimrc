local M = {}

---@param filepath string
function M.load_env_file(filepath)
    vim.g.ENV = {}

    for line in io.lines(filepath) do
        print("line: ", line)
        ---@cast line string
        local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
        if key and value then
            print("key: ", key)
            print("value: ", value)
            vim.g.ENV[key] = value
        end
    end
end

return M
