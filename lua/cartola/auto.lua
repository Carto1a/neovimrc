local autocmd = vim.api.nvim_create_autocmd
local autogroup = vim.api.nvim_create_augroup
local map = vim.api.nvim_buf_set_keymap

autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        local current_path = vim.fn.expand("%")
        if vim.fn.isdirectory(current_path) == 1 then
            vim.cmd("cd " .. current_path)
        else
            vim.cmd("cd " .. vim.fn.expand("%:h"))
        end
    end
})

autocmd('LspAttach', {
    group = autogroup('UserLspConfig', {}),
    callback = function(ev)
        local opts = { buffer = ev.buf }

        -- NOTE: para depois
        vim.o.foldcolumn = '1'
        vim.o.foldenable = true
        vim.o.fillchars = 'eob: ,fold: ,foldopen:,foldsep: ,foldclose:'
        vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'
        vim.opt.foldtext = ""
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldmethod = 'expr'

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

        -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        -- vim.keymap.set('n', '<leader>gr', require('telescope.builtin').lsp_references, opts)

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts)

        -- NOTE: não uso muito, aprender a usar ou tirar
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>ws', function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        --------------------------------------------------------------------------------------

        vim.keymap.set({ 'n', 'v' }, 'gll', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gln', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>f', function()
            -- vim.lsp.buf.format { async = true }
            require('conform').format(
                {
                    bufnr = vim.api.nvim_get_current_buf(),
                    async = true,
                    lsp_format = "fallback"
                })
        end, opts)
    end,
})

autocmd('TextYankPost', {
    group = autogroup('UserTextYankPost', {}),
    callback = function(_)
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

autocmd("FileType", {
    group = autogroup("netrw", {}),
    desc = "Netrw mappings",
    callback = function()
        if vim.bo.filetype ~= "netrw" then
            return
        end

        local opts = { silent = true }

        -- Toggle dotfiles
        map(0, "n", ".", "gh", opts)

        -- Netrw dir navigation
        map(0, "n", "l", "<cr>", opts)
        map(0, "n", "h", "-", opts)
    end
})
