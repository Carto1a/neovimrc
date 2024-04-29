vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

local function netrw_maps()
    if vim.bo.filetype ~= "netrw" then
        return
    end

    local opts = { silent = true }
    local map = vim.api.nvim_buf_set_keymap

    -- Toggle dotfiles
    map(0, "n", ".", "gh", opts)

    -- Netrw dir navigation
    map(0, "n", "l", "<cr>", opts)
    map(0, "n", "h", "-", opts)

    -- Create a new file and save it
    map(0, "n", "ff", "%:w<CR>:buffer #<CR>", opts)

    -- Create a new directory
    map(0, "n", "fa", "d", opts)

    -- Rename file
    map(0, "n", "fr", "R", opts)

    -- Remove file or directory
    map(0, "n", "fd", "D", opts)
end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("netrw", {}),
    desc = "Netrw mappings",
    callback = netrw_maps
})
