local OS = vim.uv.os_uname().sysname

local HOME_ENVIRONMENTS = {
    ["Windows_NT"] = "HOMEPATH",
    ["Linux"] = "HOME"
}

vim.g.PATH = {
    HOME = os.getenv(HOME_ENVIRONMENTS[OS]),
    NVIM_DATA = vim.fn.stdpath('data'),
    NVIM_CONFIG = vim.fn.stdpath('config')
}
