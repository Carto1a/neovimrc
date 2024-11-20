local OS = vim.uv.os_uname().sysname
local HOMEENVS = {
    ["Windows_NT"] = "HOMEPATH",
    ["Linux"] = "HOME"
}

vim.g.HOME = HOMEENVS[OS]
vim.g.NVIM_DATA = vim.fn.stdpath('data');
