local M = {
    handlers = {},
    commands = {}
}

-- from: https://github.com/seblyng/roslyn.nvim - 0c4a6f5b64122b51a64e0c8f7aae140ec979690e

local sysname = vim.uv.os_uname().sysname:lower()
local iswin = not not (sysname:find("windows") or sysname:find("mingw"))

--- Attempts to extract the project path from a line in a solution file
---@param line string
---@param target string
---@return string? path The path to the project file
local function sln_match(line, target)
    local ext = vim.fn.fnamemodify(target, ":e")

    if ext == "sln" then
        local id, name, path = line:match('Project%("{(.-)}"%).*= "(.-)", "(.-)", "{.-}"')
        if id and name and path and path:match("%.csproj$") then
            return path
        end
    elseif ext == "slnx" then
        local path = line:match('<Project Path="([^"]+)"')
        if path and path:match("%.csproj$") then
            return path
        end
    elseif ext == "slnf" then
        return line:match('"(.*%.csproj)"')
    else
        error(string.format("Unknown extension `%s` for solution: `%s`", ext, target))
    end
end

---@param buffer number
local function resolve_broad_search_root(buffer)
    local sln_root = vim.fs.root(buffer, function(fname, _)
        return fname:match("%.sln$") ~= nil or fname:match("%.slnx$") ~= nil
    end)

    local git_root = vim.fs.root(buffer, ".git")
    if sln_root and git_root then
        return git_root and sln_root:find(git_root, 1, true) and git_root or sln_root
    else
        return sln_root or git_root
    end
end

-- Dirs we are not looking for solutions inside
local ignored_dirs = {
    "obj",
    "bin",
    ".git",
}

function M.find_solutions_broad(bufnr)
    local root = resolve_broad_search_root(bufnr)
    local dirs = { root }
    local slns = {} --- @type string[]

    while #dirs > 0 do
        local dir = table.remove(dirs, 1)

        for other, fs_obj_type in vim.fs.dir(dir) do
            local name = vim.fs.joinpath(dir, other)

            if fs_obj_type == "file" then
                if name:match("%.sln$") or name:match("%.slnx$") or name:match("%.slnf$") then
                    slns[#slns + 1] = vim.fs.normalize(name)
                end
            elseif fs_obj_type == "directory" and not vim.list_contains(ignored_dirs, vim.fs.basename(name)) then
                dirs[#dirs + 1] = name
            end
        end
    end

    return slns
end

---@param target string Path to solution or solution filter file
---@return string[] Table of projects in given solution
function M.projects(target)
    local file = io.open(target, "r")
    if not file then
        return {}
    end

    local paths = {}

    for line in file:lines() do
        local path = sln_match(line, target)
        if path then
            local normalized_path = iswin and path or path:gsub("\\", "/")
            local dirname = vim.fs.dirname(target)
            local fullpath = vim.fs.joinpath(dirname, normalized_path)
            local normalized = vim.fs.normalize(fullpath)
            table.insert(paths, normalized)
        end
    end

    file:close()

    return paths
end

---Checks if a project is part of a solution/solution filter or not
---@param target string Path to the solution or solution filter
---@param project string Full path to the project's csproj file
---@return boolean
function M.exists_in_target(target, project)
    local projects = M.projects(target)

    return vim.iter(projects):find(function(it)
        return it == project
    end) ~= nil
end

---@param targets string[]
---@param csproj string
---@return string[]
local function filter_targets(targets, csproj)
    return vim.iter(targets)
        :filter(function(target)
            -- TODO: add ignore target in nvim_configuration, return false if is to ignore

            return not csproj or M.exists_in_target(target, csproj)
        end)
        :totable()
end

---@param bufnr number
---@param solutions string[]
---@param preselected_sln string?
function M.root_dir(bufnr, solutions, preselected_sln)
    if #solutions == 1 then
        local result = vim.fs.dirname(solutions[1])
        return result
    end

    local csproj = vim.fs.find(function(name)
        return name:match("%.csproj$") ~= nil
    end, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]

    local filtered_targets = filter_targets(solutions, csproj)
    if #filtered_targets > 1 then
        local config = require("roslyn.config").get()
        local chosen = config.choose_target and config.choose_target(filtered_targets)
        if chosen then
            local result = vim.fs.dirname(chosen)
            return result
        else
            if preselected_sln and vim.list_contains(filtered_targets, preselected_sln) then
                local result = vim.fs.dirname(preselected_sln)
                return result
            end

            vim.notify(
                "Multiple potential target files found. Use `:Roslyn target` to select a target.",
                vim.log.levels.INFO,
                { title = "roslyn.nvim" }
            )
            return nil
        end
    else
        local selected_solution = vim.g.roslyn_nvim_selected_solution
        local result = vim.fs.dirname(filtered_targets[1])
            or selected_solution and vim.fs.dirname(selected_solution)
            or csproj and vim.fs.dirname(csproj)
        return result
    end
end

--- Searches for files with a specific extension within a directory.
--- Only files matching the provided extension are returned.
---
--- @param dir string The directory path for the search.
--- @param extensions string[] The file extensions to look for (e.g., ".sln").
---
--- @return string[] List of file paths that match the specified extension.
function M.find_files_with_extensions(dir, extensions)
    local matches = {}

    for entry, type in vim.fs.dir(dir) do
        if type == "file" then
            for _, ext in ipairs(extensions) do
                if vim.endswith(entry, ext) then
                    matches[#matches + 1] = vim.fs.normalize(vim.fs.joinpath(dir, entry))
                end
            end
        end
    end

    return matches
end

---@param bufnr number
---@param targets string[]
---@return string?
function M.predict_target(bufnr, targets)
    local csproj = vim.fs.find(function(name)
        return name:match("%.csproj$") ~= nil
    end, { upward = true, path = vim.api.nvim_buf_get_name(bufnr) })[1]

    local filtered_targets = filter_targets(targets, csproj)

    return filtered_targets[1]
end

function M.sln(client, solution)
    vim.g.roslyn_nvim_selected_solution = solution

    vim.notify("Initializing Roslyn for: " .. solution, vim.log.levels.INFO, { title = "roslyn.nvim" })

    client:notify("solution/open", {
        solution = vim.uri_from_fname(solution),
    })

    vim.api.nvim_exec_autocmds("User", {
        pattern = "RoslynOnInit",
        data = {
            type = "solution",
            target = solution,
            client_id = client.id,
        },
    })
end

function M.project(client, projects)
    vim.notify("Initializing Roslyn for: project", vim.log.levels.INFO, { title = "roslyn.nvim" })

    client:notify("project/open", {
        projects = vim.tbl_map(function(file)
            return vim.uri_from_fname(file)
        end, projects),
    })

    vim.api.nvim_exec_autocmds("User", {
        pattern = "RoslynOnInit",
        data = {
            type = "project",
            target = projects,
            client_id = client.id,
        },
    })
end

M.handlers["workspace/projectInitializationComplete"] = function(_, _, ctx)
    vim.notify("Roslyn project initialization complete", vim.log.levels.INFO, { title = "roslyn.nvim" })

    ---NOTE: This is used by rzls.nvim for init
    vim.api.nvim_exec_autocmds("User", {
        pattern = "RoslynInitialized",
        modeline = false,
        data = { client_id = ctx.client_id },
    })
    _G.roslyn_initialized = true

    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    local buffers = vim.lsp.get_buffers_by_client_id(ctx.client_id)
    for _, buf in ipairs(buffers) do
        local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
        client:request("textDocument/diagnostic", params, nil, buf)
    end
end

M.handlers["workspace/refreshSourceGeneratedDocument"] = function(_, _, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        local uri = vim.api.nvim_buf_get_name(buf)
        if vim.api.nvim_buf_get_name(buf):match("^roslyn%-source%-generated://") then
            local function handler(err, result)
                assert(not err, vim.inspect(err))
                if vim.b[buf].resultId == result.resultId then
                    return
                end
                local content = result.text
                if content == nil then
                    content = ""
                end
                local normalized = string.gsub(content, "\r\n", "\n")
                local source_lines = vim.split(normalized, "\n", { plain = true })
                vim.bo[buf].modifiable = true
                vim.api.nvim_buf_set_lines(buf, 0, -1, false, source_lines)
                vim.b[buf].resultId = result.resultId
                vim.bo[buf].modifiable = false
            end

            local params = {
                textDocument = {
                    uri = uri,
                },
                resultId = vim.b[buf].resultId,
            }

            ---@diagnostic disable-next-line: param-type-mismatch
            client:request("sourceGeneratedDocument/_roslyn_getText", params, handler, buf)
        end
    end
end

M.handlers["workspace/_roslyn_projectNeedsRestore"] = function(_, result, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

    local function uuid()
        local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
        return string.gsub(template, "[xy]", function(c)
            local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
            return string.format("%x", v)
        end)
    end

    local token = uuid()
    result.partialResultToken = token

    local id = vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(ev)
            local params = ev.data.params
            if params[1] ~= token then
                return
            end

            vim.api.nvim_exec_autocmds("User", {
                pattern = "RoslynRestoreProgress",
                data = ev.data,
            })
        end,
    })

    ---@diagnostic disable-next-line: param-type-mismatch
    client:request("workspace/_roslyn_restore", result, function(err, res)
        vim.api.nvim_exec_autocmds("User", {
            pattern = "RoslynRestoreResult",
            data = {
                token = token,
                err = err,
                res = res,
            },
        })

        vim.api.nvim_del_autocmd(id)
    end)

    return vim.NIL
end

---@class RoslynCodeAction
---@field title string
---@field code_action table

---@return RoslynCodeAction
local function get_code_actions(nested_code_actions)
    return vim.iter(nested_code_actions)
        :map(function(it)
            local code_action_path = it.data.CodeActionPath
            local fix_all_flavors = it.data.FixAllFlavors

            if #code_action_path == 1 then
                return {
                    title = code_action_path[1],
                    code_action = it,
                }
            end

            local title = table.concat(code_action_path, " -> ", 2)
            return {
                title = fix_all_flavors and string.format("Fix All: %s", title) or title,
                code_action = it,
            }
        end)
        :totable()
end

local function handle_fix_all_code_action(client, data)
    local flavors = data.arguments[1].FixAllFlavors
    vim.ui.select(flavors, { prompt = "Pick a fix all scope:" }, function(flavor)
        client:request("codeAction/resolveFixAll", {
            title = data.title,
            data = data.arguments[1],
            scope = flavor,
        }, function(err, response)
            if err then
                vim.notify(err.message, vim.log.levels.ERROR, { title = "roslyn.nvim" })
            end
            if response and response.edit then
                vim.lsp.util.apply_workspace_edit(response.edit, client.offset_encoding)
            end
        end)
    end)
end

--- @return [integer, integer] # (row, col) tuple
local function offset_to_position(bufnr, offset)
    local text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, true), "\n")
    local sub = text:sub(1, offset)
    local line = 0
    for _ in sub:gmatch("([^\n]*)\n?") do
        line = line + 1
    end
    local last_newline = sub:match(".*()\n")
    local col = offset - (last_newline or 0)
    return { line - 1, col }
end

M.commands["roslyn.client.fixAllCodeAction"] = function(data, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    handle_fix_all_code_action(client, data)
end

M.commands["roslyn.client.nestedCodeAction"] = function(data, ctx)
    local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
    local args = data.arguments[1]
    local code_actions = get_code_actions(args.NestedCodeActions)
    local titles = vim.iter(code_actions)
        :map(function(it)
            return it.title
        end)
        :totable()

    vim.ui.select(titles, { prompt = args.UniqueIdentifier }, function(selected)
        local action = vim.iter(code_actions):find(function(it)
            return it.title == selected
        end) --[[@as RoslynCodeAction]]

        if action.code_action.data.FixAllFlavors then
            handle_fix_all_code_action(client, action.code_action.command)
        else
            client:request("codeAction/resolve", {
                title = action.code_action.title,
                data = action.code_action.data,
                ---@diagnostic disable-next-line: param-type-mismatch
            }, function(err, response)
                if err then
                    vim.notify(err.message, vim.log.levels.ERROR, { title = "roslyn.nvim" })
                end
                if response and response.edit then
                    vim.lsp.util.apply_workspace_edit(response.edit, client.offset_encoding)
                end
            end)
        end
    end)
end

M.commands["roslyn.client.completionComplexEdit"] = function(data)
    local doc, edit, _, new_offset = unpack(data.arguments)
    local bufnr = vim.uri_to_bufnr(doc.uri)

    if not vim.api.nvim_buf_is_loaded(bufnr) then
        vim.fn.bufload(bufnr)
    end

    local start_row = edit.range.start.line
    local start_col = edit.range.start.character
    local end_row = edit.range["end"].line
    local end_col = edit.range["end"].character

    -- It's possible to get corrupted line endings in the newText from the LSP
    -- Somehow related to typing fast
    -- Notification(int what)\r\n    {\r\n        base._Notification(what);\r\n    }\r\n\r\n\r
    local newText = edit.newText:gsub("\r\n", "\n"):gsub("\r", "")
    local lines = vim.split(newText, "\n")

    vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, end_col, lines)

    local final_line = start_row + #lines - 1
    local final_line_text = vim.api.nvim_buf_get_lines(bufnr, final_line, final_line + 1, false)[1]

    -- Handle auto-inserted parentheses
    -- "}" or ";" followed only by at least one of "(", ")", or whitespace at the end of the line
    if final_line_text:match("[};][()%s]+$") then
        local new_final_line_text = final_line_text:gsub("([};])[()%s]+$", "%1")
        lines[#lines] = new_final_line_text
        vim.api.nvim_buf_set_lines(bufnr, final_line, final_line + 1, false, { new_final_line_text })
    end

    if new_offset >= 0 then
        vim.api.nvim_win_set_cursor(0, offset_to_position(0, new_offset))
    end
end

return M
