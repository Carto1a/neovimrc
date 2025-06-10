local M = {
    file_name = "config.json",
    config_path = nil,
    configuration = nil,
    notify = true,
    decoder = vim.json.decode
}

local function decode(data)
    if not M.decoder then return end
    M.configuration = M.decoder(data)
end

local function readfile(filepath)
    local fd = vim.uv.fs_open(filepath, 'r', 400)
    assert(fd)
    local stat = vim.uv.fs_fstat(fd)
    assert(stat)

    local data = vim.uv.fs_read(fd, stat.size, 0)
    assert(data)

    assert(vim.uv.fs_close(fd))

    return data
end

local function notify(msg, level)
    if M.notify then vim.notify(msg, level or vim.log.levels.WARN) end
end

local function on_change(err, fname, status)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end

    print("on_change")
    decode(readfile(M.config_path))
    if status.change then
        if M.event_handler then
            M.event_handler:stop()
            M.event_handler:start(M.config_path, {}, on_change)
        end

        vim.schedule(function()
            vim.api.nvim_exec_autocmds('User', { pattern = 'ConfigChange' })
        end)
    end
end

function M.setup(setup_args)
    M.config_path = vim.fn.expand("./.config.json")

    if not vim.uv.fs_stat(M.config_path) then
        return
    end

    -- TODO: check for fail
    M.event_handler = vim.uv.new_fs_event()

    decode(readfile(M.config_path))

    -- TODO: check for fail
    M.event_handler:start(M.config_path, {}, on_change)
end

function M.get(key)
    if M.configuration == nil then
        return nil
    end

    local keys = vim.split(key, "%.")
    local keys_len = #keys
    local configuration = M.configuration
    for index, key_value in ipairs(keys) do
        if configuration == nil then
            return configuration
        end

        configuration = configuration[key_value];

        if index >= keys_len then
            return configuration
        end
    end
end

return M
