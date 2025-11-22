vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                -- make language server aware of runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.stdpath('config') .. '/lua'] = true,
                },
            },
        }
    }
})
