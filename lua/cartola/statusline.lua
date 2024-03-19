local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	-- [""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

local function get_mode()
	
end

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local function statusline()
	local mode = modes[vim.api.nvim_get_mode().mode]
	return table.concat({
		mode,
		1
	})
end

-- Define variáveis de cor
local stslineColorRed     = "Red"
local stslineColorGreen   = "Green"
local stslineColorBlue    = "Blue"
local stslineColorMagenta = "DarkMagenta"
local stslineColorYellow  = "Yellow"
local stslineColorOrange  = "Orange"

local stslineColorLight   = "White"
local stslineColorDark    = "Black"
local stslineColorDark1   = "DarkGray"
local stslineColorDark2   = "Gray"
local stslineColorDark3   = "Black"

-- Define cores
--vim.cmd('hi StslinePriColorBG guifg=' .. stslineColorDark2 .. ' guibg=' .. stslineColorLight .. ' gui=bold')

local b = {} -- Adicione esta linha para criar uma tabela para armazenar variáveis globais

function b.statuslineGitBranch()
	local gitbranch = ""
	if vim.bo.modifiable then
		local dir = vim.fn.expand('%:p:h')
		local gitrevparse = vim.fn.system("git -C " .. dir .. " rev-parse --abbrev-ref HEAD")
		if vim.v.shell_error == 0 then
			gitbranch = "  " .. vim.fn.substitute(gitrevparse, '\n', '', 'g') .. "  "
		end
	end
	return gitbranch
end

--vim.cmd([[
--augroup GetGitBranch
--autocmd!
--autocmd VimEnter,WinEnter,BufEnter * let b:gitbranch = luaeval("statuslineGitBranch()")
--augroup END
--]])

function stslineMode()
	local currentMode = vim.fn.mode()

	local stslinePriColor
	local stslineOnPriColor
	local stslineOnSecColor

	local currentModeString

	if currentMode == "n" then
		stslinePriColor = stslineColorGreen
		currentModeString = "NORMAL "
	elseif currentMode == "i" then
		stslinePriColor = stslineColorMagenta
		currentModeString = "INSERT "
	elseif currentMode == "c" then
		stslinePriColor = stslineColorYellow
		currentModeString = "COMMAND "
	elseif currentMode == "v" then
		stslinePriColor = stslineColorBlue
		currentModeString = "VISUAL "
	elseif currentMode == "V" then
		stslinePriColor = stslineColorBlue
		currentModeString = "V-LINE "
	elseif currentMode == "\\<C-v>" then
		stslinePriColor = stslineColorBlue
		currentModeString = "V-BLOCK "
	elseif currentMode == "R" then
		stslinePriColor = stslineColorRed
		currentModeString = "REPLACE "
	elseif currentMode == "s" then
		stslinePriColor = stslineColorBlue
		currentModeString = "SELECT "
	elseif currentMode == "t" then
		stslinePriColor = stslineColorYellow
		currentModeString = "TERM "
	elseif currentMode == "!" then
		stslinePriColor = stslineColorYellow
		currentModeString = "SHELL "
	end

	updateStslineColors()

	return currentModeString
end

function deactivateStatusline()
	vim.wo.statusline = '%#CursorColumn# INACTIVE %#CursorColumn#%{b.statuslineGitBranch()}%#LineNr# %f%m%r%= %{&fileencoding?&fileencoding:&encoding} \\| %{&fileformat} \\| %Y %#CursorColumn# %P   %l:%c '
end

function activateStatusline()
	vim.wo.statusline = '%#StslinePriColorBG# %{stslineMode()}%#CursorColumn#%{b.statuslineGitBranch()}%#LineNr# %f%m%r%= %{&fileencoding?&fileencoding:&encoding} \\| %{&fileformat} \\| %Y %#CursorColumn# %P %#StslinePriColorBG#   %l:%c '
end

function updateStslineColors()
	vim.cmd('highlight StslinePriColorBG guifg=' .. stslineColorDark2 .. ' guibg=' .. stslineColorLight .. ' gui=bold')
end

vim.cmd('set laststatus=2')
vim.cmd('set noshowmode')

--vim.wo.statusline = '%#StslinePriColorBG# %{stslineMode()}%#CursorColumn#%{b.statuslineGitBranch()}%#LineNr# %f%m%r%= %{&fileencoding?&fileencoding:&encoding} \\| %{&fileformat} \\| %Y %#CursorColumn# %P %#StslinePriColorBG#   %l:%c '
vim.opt.statusline = "%!v:lua.statusline()"
--vim.cmd([[
--augroup SetStslineline
--autocmd!
--autocmd BufEnter,WinEnter * lua activateStatusline()
--autocmd BufLeave,WinLeave * lua deactivateStatusline()
--augroup END
--]])

