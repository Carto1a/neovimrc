local M = {
    file_name = "config.json",
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
    local config_path = vim.uv.cwd() .. '/.config.json'
    decode(readfile(config_path))
    vim.schedule(function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ConfigChange' })
    end)
end

function M.setup(setup_args)
    local config_path = vim.fn.expand("./.config.json")

    if not vim.uv.fs_stat(config_path) then
        notify("file not exist")
        return
    end

    -- TODO: check for fail
    M.event_handler = vim.uv.new_fs_event()

    decode(readfile(config_path))

    -- TODO: check for fail
    M.event_handler:start(config_path, {}, on_change)
end

function M.get(key)
    if M.configuration == nil then
        notify("config not exist")
        return nil
    end

    return M.configuration[key];
end

return M
