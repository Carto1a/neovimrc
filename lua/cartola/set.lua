vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard:append("unnamed", "unnamedplus")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.incsearch = true
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.foldmethod = "manual"
vim.opt.foldlevelstart = 99
vim.opt.breakindent = true
--vim.opt.autochdir = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.updatetime = 50

vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = {
	trail = "~",
	eol = "·",
	-- tab = '│ ',
	tab = "  ",
	extends = ">",
	precedes = "<",
	multispace = " ",
	lead = "-",
}
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.mouse = "a"
vim.opt.conceallevel = 1
vim.opt.termguicolors = true

--let g:netrw_banner=0
