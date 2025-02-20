local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
local filetype_group = autogroup("filetype_sets", {})

autocmd("FileType", {
    pattern = "nix",
    group = filetype_group,
    callback = function(_)
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.expandtab = true
    end
})

autocmd('FileType', {
    pattern = { 'markdown', 'text', 'gitcommit' },
    group = filetype_group,
    callback = function()
        vim.opt.textwidth = 80
        vim.opt.spelllang = 'pt_br,en_us'
        vim.opt.wrap = true
    end,
})

autocmd("FileType", {
    pattern = "gdscript",
    group = filetype_group,
    callback = function()
        vim.opt.expandtab = false
    end
})
