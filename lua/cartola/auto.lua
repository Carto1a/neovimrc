local autocmd = vim.api.nvim_create_autocmd

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
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        local opts = { buffer = args.buf }

        vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

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
    callback = function(_)
        vim.hl.on_yank({ timeout = 150 })
    end,
})
