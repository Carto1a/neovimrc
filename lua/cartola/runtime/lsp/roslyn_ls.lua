local util = require("cartola.lsp")
local roslyn = require("core.roslyn")
local server_name = "roslyn_ls"

local settings = util.get_servers_settings(server_name)
local configuration = settings.internal or {}


configuration.root_dir = function(bufnr, on_dir)
    local buf_name = vim.api.nvim_buf_get_name(bufnr)

    -- For source-generated files, use the root_dir from the existing client
    if buf_name:match("^roslyn%-source%-generated://") then
        local existing_client = vim.lsp.get_clients({ name = "roslyn" })[1]
        if existing_client and existing_client.config.root_dir then
            on_dir(existing_client.config.root_dir)
            return
        end
    end

    local solutions = roslyn.find_solutions_broad(bufnr)
    local root_dir = roslyn.root_dir(bufnr, solutions, vim.g.roslyn_nvim_selected_solution)

    on_dir(root_dir)
end

configuration.on_init = function(client)
    if not client.config.root_dir then
        return
    end

    local lock_target = false

    local selected_solution = vim.g.roslyn_nvim_selected_solution
    if lock_target and selected_solution then
        return roslyn.sln(client, selected_solution)
    end

    local files = roslyn.find_files_with_extensions(client.config.root_dir, { ".sln", ".slnx", ".slnf" })

    local bufnr = vim.api.nvim_get_current_buf()
    local solution = roslyn.predict_target(bufnr, files)
    if solution then
        return roslyn.sln(client, solution)
    end

    local csproj = roslyn.find_files_with_extensions(client.config.root_dir, { ".csproj" })
    if #csproj > 0 then
        return roslyn.project(client, csproj)
    end

    if selected_solution then
        return roslyn.sln(client, selected_solution)
    end
end

configuration.on_exit = function()
    vim.g.roslyn_nvim_selected_solution = nil
    vim.schedule(function()
        -- require("roslyn.roslyn_emitter"):emit("stopped")
        vim.notify("Roslyn server stopped", vim.log.levels.INFO, { title = "roslyn.nvim" })
    end)
end

configuration.handlers = roslyn.handlers
configuration.commands = roslyn.commands

return configuration
