vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        local current_path = vim.fn.expand("%")
        if vim.fn.isdirectory(current_path) == 1 then
            vim.cmd("cd " .. current_path)
        else
            vim.cmd("cd " .. vim.fn.expand("%:h"))
        end
    end
})
