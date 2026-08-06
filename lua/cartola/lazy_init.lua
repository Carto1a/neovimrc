local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "cartola.lazy" },
    },
    -- root = vim.fn.stdpath("data") .. vim.g.PROFILE .. "/lazy",
    -- lockfile = vim.fn.stdpath("config") .. vim.g.PROFILE .. "/lazy-lock.json",
    -- state = vim.fn.stdpath("state") .. vim.g.PROFILE "/lazy/state.json",
    change_detection = {
        enabled = true,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrwPlugin"
            }
        }
    }
})
