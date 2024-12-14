local function start_server(args)
    local pipepath = vim.fn.stdpath("cache") .. "/godot.pipe"

    if args == "start" then
        if not vim.uv.fs_stat(pipepath) then
            print("GodotServer start")
            vim.fn.serverstart(pipepath)
        end

        return
    end

    print("GodotServer stop")

    if not vim.uv.fs_stat(pipepath) then
        vim.fn.serverstop(pipepath)
    end
end

vim.api.nvim_create_user_command('GodotServer', function(opts)
    start_server(opts.args)
end, {
    nargs = 1,
    complete = function()
        return { "start", "stop" }
    end
})
