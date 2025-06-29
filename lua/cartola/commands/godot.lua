local M = {
    enable = false,
    default_pipe_path = vim.fn.stdpath("cache") .. "/godot.pipe",
}

---@param pipe_path? string
function M.godot_toggle_server(pipe_path)
    local pipepath = pipe_path or M.default_pipe_path
    M.enable = not M.enable

    if M.enable then
        if not vim.uv.fs_stat(pipepath) then
            vim.fn.serverstart(pipepath)
        end

        return
    end

    if not vim.uv.fs_stat(pipepath) then
        vim.fn.serverstop(pipepath)
    end
end

vim.api.nvim_create_user_command('GodotServer', function(opts)
    M.godot_toggle_server(opts.fargs[1])
end, {
    nargs = "?",
    complete = "file"
})

return M
