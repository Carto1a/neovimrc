-- NOTE: ta feio, refatorar 

if vim.g.PROFILE == nil then return end

local config_name = "nvim_config.json"

---@type fun(err: string|nil, filename: string, events: uv.fs_event_start.callback.events)
local on_change = nil

local M = {
    project = {
        path = vim.fn.expand("." .. config_name),
        event_handler = nil
    },

    global = {
        configuration = {},
        path = vim.fs.joinpath(vim.g.PATH.NVIM_CONFIG, "lua", vim.g.PROFILE, "profile.json"),
        event_handler = nil
    },

    configuration = nil,
}

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

local function on_change_global()
    local configuration = vim.json.decode(readfile(M.global.path))

    if M.global.event_handler == nil then return end

    M.global.event_handler:stop()
    M.global.event_handler:start(M.global.path, {}, on_change)

    M.global.configuration = configuration
end

local function on_change_project()
    local configuration = vim.json.decode(readfile(M.project.path))

    M.configuration = vim.tbl_deep_extend("force", configuration, M.global.configuration)

    if M.project.event_handler == nil then return end

    M.project.event_handler:stop()
    M.project.event_handler:start(M.project.path, {}, on_change)
end

on_change = function(err, fname, status)
    if err then
        vim.notify(err, vim.log.levels.ERROR)
        return
    end

    if not status.change then return end

    print("on_change")

    if fname == "profile.json" then
        on_change_global()
    else
        on_change_project()
    end

    vim.schedule(function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'ConfigChange' })
    end)
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

local function initalize_configuration(fname)
    if not vim.uv.fs_stat(fname) then return nil, nil, "file not exist" end

    local event_handler, err = vim.uv.new_fs_event()
    if err then return nil, nil, err end

    local configuration = vim.json.decode(readfile(fname))

    return configuration, event_handler, nil
end

local function initalize_global()
    local configuration, event_handler, err = initalize_configuration(M.global.path)
    if err then return end
    if event_handler == nil then return end

    M.global.configuration = configuration
    M.global.event_handler = event_handler
    M.configuration = configuration

    event_handler:start(M.global.path, {}, on_change)
end

local function initalize_project()
    local configuration, event_handler, err = initalize_configuration(M.project.path)
    if err then return end
    if event_handler == nil then return end

    M.configuration = vim.tbl_deep_extend("force", configuration, M.global.configuration)
    M.project.event_handler = event_handler

    event_handler:start(M.project.path, {}, on_change)
end

initalize_global()
initalize_project()

return M
