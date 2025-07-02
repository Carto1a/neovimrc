local M = {}
local uppercase_pattern = "[A-Z]"

function EOL()
    local buf = vim.api.nvim_get_current_buf()
    local eol = vim.api.nvim_buf_line_count(buf)
    local row = vim.api.nvim_win_get_cursor(0)[1]

    return row == eol
end

function SOL()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    return row == 1
end

function Find_previus_uppercase(line, col)
    local line_len = string.len(line)
    local col_normalize = line_len - col + 1
    line = line:reverse()
    local index = string.find(line, uppercase_pattern, col_normalize)
    if index then
        return line_len - index
    end
    return index
end

function Find_next_uppercase(line, col)
    local index = string.find(line, uppercase_pattern, col + 2)
    if index then
        return index - 1
    end
    return index
end

function M.Jump_to_uppercase(reverse)
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2]
    local row = cursor[1]

    local next_pos
    if reverse then
        next_pos = Find_previus_uppercase(line, col)
    else
        next_pos = Find_next_uppercase(line, col)
    end

    if next_pos then
        vim.api.nvim_win_set_cursor(0, { row, next_pos })
        return
    end

    if not EOL() and not reverse then
        vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
        M.Jump_to_uppercase(false)
        return
    end

    if not SOL() and reverse then
        local previus_line = vim.api.nvim_buf_get_lines(
            0, row - 2, row - 1, true)[1]

        local eol = string.len(previus_line)
        vim.api.nvim_win_set_cursor(0, { row - 1, eol })
        M.Jump_to_uppercase(true)
        return
    end
end

return M
