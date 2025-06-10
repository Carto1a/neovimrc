local OS = vim.uv.os_uname().sysname

local HOME_ENVIRONMENTS = {
    ["Windows_NT"] = "HOMEPATH",
    ["Linux"] = "HOME"
}

vim.g.HOME = HOME_ENVIRONMENTS[OS]
vim.g.NVIM_DATA = vim.fn.stdpath('data');
