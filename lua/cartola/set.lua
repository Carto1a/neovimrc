vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.wrapmargin = 1
vim.opt.spell = true
vim.opt.spelllang = 'pt_br,en_us'
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.fileformat = "unix"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.g.PATH.HOME .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = {
    trail = "~",
    eol = "·",
    tab = "  ",
    extends = ">",
    precedes = "<",
    multispace = " ",
    lead = " ",
    nbsp = "*"
}

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "95"
vim.opt.mouse = "a"
vim.opt.conceallevel = 1
vim.opt.termguicolors = true

vim.g.netrw_bufsettings = 'ma nomod nu rnu nobl nowrap noro scl=yes'
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

vim.opt.smoothscroll = true

vim.diagnostic.config({
    update_in_insert = true,
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
    },

    virtual_text = true,
    signs = true,
    underline = false,
    severity_sort = false,
})

vim.o.foldcolumn = '1'
vim.o.foldenable = true
vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
vim.o.foldtext = ""
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
