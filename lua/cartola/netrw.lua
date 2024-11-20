vim.g.netrw_bufsettings = 'ma nomod nu rnu nobl nowrap noro scl=yes'
vim.g.netrw_list_hide = '\\(^\\|\\s\\s\\)\\zs\\.\\S\\+'

local function netrw_maps()
    if vim.bo.filetype ~= "netrw" then
        return
    end

    local opts = { silent = true }
    local map = vim.api.nvim_buf_set_keymap

    -- Toggle dotfiles
    map(0, "n", ".", "gh", opts)

    -- Netrw dir navigation
    map(0, "n", "l", "<cr>", opts)
    map(0, "n", "h", "-", opts)

    -- Create a new file and save it
    map(0, "n", "ff", "%:w<CR>:buffer #<CR>", opts)

    -- Create a new directory
    map(0, "n", "fa", "d", opts)

    -- Rename file
    map(0, "n", "fr", "R", opts)

    -- Remove file or directory
    map(0, "n", "fd", "D", opts)
end

-- local is_empty = function(str)
--   return str == "" or str == nil
-- end

-- local function draw_icons()
--     local is_devicons_available, devicons = xpcall(require, debug.traceback, "nvim-web-devicons")
--     if not is_devicons_available then
--         return
--     end
--     local default_signs = {
--         netrw_dir = {
--             text = "",
--             texthl = "netrwDir",
--         },
--         netrw_file = {
--             text = "",
--             texthl = "netrwPlain",
--         },
--         netrw_exec = {
--             text = "",
--             texthl = "netrwExe",
--         },
--         netrw_link = {
--             text = "",
--             texthl = "netrwSymlink",
--         },
--     }

--     local bufnr = vim.api.nvim_win_get_buf(0)

--     -- Unplace all signs
--     vim.fn.sign_unplace("*", { buffer = bufnr })

--     -- Define default signs
--     for sign_name, sign_opts in pairs(default_signs) do
--         vim.fn.sign_define(sign_name, sign_opts)
--     end

--     local cur_line_nr = 1
--     local total_lines = vim.fn.line("$")
--     while cur_line_nr <= total_lines do
--         -- Set default sign
--         local sign_name = "netrw_file"

--         -- Get line contents
--         local line = vim.fn.getline(cur_line_nr)

--         if is_empty(line) then
--             -- If current line is an empty line (newline) then increase current line count
--             -- without doing nothing more
--             cur_line_nr = cur_line_nr + 1
--         else
--             -- print(line)
--             if line:find("/$") then
--                 sign_name = "netrw_dir"
--             elseif line:find("@%s+-->") then
--                 sign_name = "netrw_link"
--             elseif line:find("*$") then
--                 sign_name:find("netrw_exec")
--             else
--                 local filetype = line:match("^.*%.(.*)")
--                 if not filetype and line:find("LICENSE") then
--                     filetype = "md"
--                 elseif line:find("rc$") then
--                     filetype = "conf"
--                 end

--                 -- If filetype is still nil after manually setting extensions
--                 -- for unknown filetypes then let's use 'default'
--                 if not filetype then
--                     filetype = "default"
--                 end

--                 local icon, icon_highlight = devicons.get_icon(line, filetype, { default = "" })
--                 sign_name = "netrw_" .. filetype
--                 vim.fn.sign_define(sign_name, {
--                     text = icon,
--                     texthl = icon_highlight,
--                 })
--             end
--             vim.fn.sign_place(cur_line_nr, sign_name, sign_name, bufnr, {
--                 lnum = cur_line_nr,
--             })
--             cur_line_nr = cur_line_nr + 1
--         end
--     end
-- end

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("netrw", {}),
    desc = "Netrw mappings",
    callback = function()
        netrw_maps()
        -- draw_icons()
    end
})

-- function IsIgnored(file)
--     local output = vim.fn.system('git check-ignore ' .. vim.fn.fnameescape(file))
--     return output ~= ''
-- end

-- function NetrwGitIgnored()
--     print(vim.bo.filetype)
--     local curDir = vim.fn.expand('%:p:h')
--     if vim.bo.filetype ~= 'netrw' then
--         return
--     end
--     if curDir == vim.g.netrw_curdir then
--         return
--     end
--     vim.g.netrw_curdir = curDir
--     local lc = 1
--     while lc <= vim.fn.line('$') do
--         local line = vim.fn.getline(lc)
--         line = line:gsub("^....", "")
--         local file = line
--         if IsIgnored(file) then
--             vim.fn.setline(lc, "! " .. file)
--         end
--         lc = lc + 1
--     end
-- end

-- -- vim.api.nvim_exec([[
-- --     augroup NetrwGitIgnored
-- --         autocmd!
-- --         autocmd BufEnter * call NetrwGitIgnored()
-- --     augroup END

-- --     function! NetrwGitIgnored()
-- --         let l:curDir = expand('%:p:h')
-- --         echo &filetype
-- --         if &filetype == 'netrw' && l:curDir != g:netrw_curdir
-- --             let g:netrw_curdir = l:curDir
-- --             let l:lc = 1
-- --             while l:lc <= line('$')
-- --                 let l:line = getline(l:lc)
-- --                 let l:line = substitute(l:line, "^....", "", "")
-- --                 let l:file = l:line
-- --                 let l:line = l:lc
-- --                 let l:lc += 1
-- --                 if IsIgnored(l:file)
-- --                     call setline(l:line, "! " . l:file)
-- --                 endif
-- --             endwhile
-- --         endif
-- --     endfunction
-- -- ]], false)

-- vim.api.nvim_create_autocmd("FileType", {
--     -- group = vim.api.nvim_create_augroup("netrwx", {}),
--     desc = "Netrw icons",
--     callback = function (ev)
--         print("netrw")
--         -- draw_icons()
--         -- NetrwGitIgnored()
--     end
-- })
