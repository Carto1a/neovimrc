vim.api.nvim_create_user_command('Vimcfg', function(opts)
    local plugin = opts.args
    local config = vim.fn.stdpath('config')
    local path = config

    if plugin ~= "" then
        path = config .. '/lua/cartola/lazy/' .. plugin
    end

    vim.cmd('tabedit' .. path)
    vim.cmd('tcd' .. config)
end, {
    nargs = '?',
    complete = function(_, _, _)
        local lazy_path = vim.fn.stdpath('config') .. '/lua/cartola/lazy'
        local dirs = vim.fn.globpath(lazy_path, '*', 0, 1)
        local result = {}
        for _, dir in ipairs(dirs) do
            if vim.fn.isdirectory(dir) then
                table.insert(result, vim.fn.fnamemodify(dir, ':t'))
            end
        end

        return result
    end
})
