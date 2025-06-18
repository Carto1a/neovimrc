local M = {}

vim.g.ENV = {}

---@param filepath string
function M.load_env_file(filepath)
    assert(filepath, "env path not provided")

    if not vim.uv.fs_stat(filepath) then return end

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
