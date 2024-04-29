vim.g.netrw_bufsettings = 'noma nomod nu rnu nobl nowrap ro'

---- Netrw banner
---- 0 : Disable banner
---- 1 : Enable banner
--vim.g.netrw_banner = 0

---- Keep the current directory and the browsing directory synced.
---- This helps you avoid the move files error.
-- vim.g.netrw_keepdir = 0

---- Show directories first (sorting)
-- vim.g.netrw_sort_sequence = [[[\/]$,*]]

---- Human-readable files sizes
--vim.g.netrw_sizestyle = "H"

------ Patterns for hiding files, e.g. node_modules
------ NOTE: this works by reading '.gitignore' file
----vim.g.netrw_list_hide = vim.fn["netrw_gitignore#Hide"]()

------ Preview files in a vertical split window
--vim.g.netrw_preview = 1

------ Open files in split
------ 0 : re-use the same window (default)
------ 1 : horizontally splitting the window first
------ 2 : vertically   splitting the window first
------ 3 : open file in new tab
------ 4 : act like "P" (ie. open previous window)
--vim.g.netrw_browse_split = 0

--local function netrw_maps()
--    if vim.bo.filetype ~= "netrw" then
--        return
--    end

--    local opts = { silent = true }
--    -- Toggle dotfiles
--    vim.api.nvim_buf_set_keymap(0, "n", ".", "gh", opts)

--    -- Open file and close netrw
--    vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>:Lexplore<CR>", opts)

--    -- Open file or directory
--    vim.api.nvim_buf_set_keymap(0, "n", "o", "<CR>", opts)

--    -- Show netrw help in a floating (or maybe sidebar?) window
--    -- TODO: implement show_help function so we can implement this mapping
--    --[[ vim.api.nvim_buf_set_keymap(
--    0,
--    "n",
--    "?",
--    ":lua require('doom.core.settings.netrw').show_help()<CR>",
--    opts
--  ) ]]

--    -- Close netrw
--    vim.api.nvim_buf_set_keymap(0, "n", "q", ":Lexplore<CR>", opts)

--    -- Create a new file and save it
--    vim.api.nvim_buf_set_keymap(0, "n", "ff", "%:w<CR>:buffer #<CR>", opts)

--    -- Create a new directory
--    vim.api.nvim_buf_set_keymap(0, "n", "fa", "d", opts)

--    -- Rename file
--    vim.api.nvim_buf_set_keymap(0, "n", "fr", "R", opts)

--    -- Remove file or directory
--    vim.api.nvim_buf_set_keymap(0, "n", "fd", "D", opts)

--    -- Copy marked file
--    vim.api.nvim_buf_set_keymap(0, "n", "fc", "mc", opts)

--    -- Copy marked file in one step, with this we can put the cursor in a directory
--    -- after marking the file to assign target directory and copy file
--    vim.api.nvim_buf_set_keymap(0, "n", "fC", "mtmc", opts)

--    -- Move marked file
--    vim.api.nvim_buf_set_keymap(0, "n", "fx", "mm", opts)

--    -- Move marked file in one step, same as fC but for moving files
--    vim.api.nvim_buf_set_keymap(0, "n", "fX", "mtmm", opts)

--    -- Execute commands in marked file or directory
--    vim.api.nvim_buf_set_keymap(0, "n", "fe", "mx", opts)

--    -- Show a list of marked files and directories
--    vim.api.nvim_buf_set_keymap(
--        0,
--        "n",
--        "fm",
--        ':echo "Marked files:\n" . join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>',
--        opts
--    )

--    -- Show target directory
--    vim.api.nvim_buf_set_keymap(
--        0,
--        "n",
--        "ft",
--        ':echo "Target: " . netrw#Expose("netrwmftgt")<CR>',
--        opts
--    )

--    -- Toggle the mark on a file or directory
--    vim.api.nvim_buf_set_keymap(0, "n", "<TAB>", "mf", opts)

--    -- Unmark all the files in the current buffer
--    vim.api.nvim_buf_set_keymap(0, "n", "<S-TAB>", "mF", opts)

--    -- Remove all the marks on all files
--    vim.api.nvim_buf_set_keymap(0, "n", "<Leader><TAB>", "mu", opts)

--    -- Create a bookmark
--    vim.api.nvim_buf_set_keymap(0, "n", "bc", "mb", opts)

--    -- Remove the most recent bookmark
--    vim.api.nvim_buf_set_keymap(0, "n", "bd", "mB", opts)

--    -- Jumo to the most recent bookmark
--    vim.api.nvim_buf_set_keymap(0, "n", "bj", "gb", opts)
--end

---- NOTE: não esta funcionando
--vim.api.nvim_create_autocmd("FileType", {
--    group = vim.api.nvim_create_augroup("netrw", {}),
--    callback = netrw_maps
--})

