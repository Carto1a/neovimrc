local OS = vim.loop.os_uname().sysname
local HOMEPATHS = {
    ["Windows_NT"] = "HOMEPATH",
    ["Linux"] = "HOME"
}

vim.g.HOME = HOMEPATHS[OS]
vim.g.NVIM_DATA = vim.fn.stdpath('data');
