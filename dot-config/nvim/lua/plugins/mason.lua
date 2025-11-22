return {
    'mason-org/mason-lspconfig.nvim',
    opts = {
        ensure_installed = { 'lua_ls' },
    },
    dependencies = {
        { 'mason-org/mason.nvim', opts = {} },
        'neovim/nvim-lspconfig',
    },
    config = function()
        local lspconfig = require('mason-lspconfig')
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        lspconfig.setup({})

        for _, server in ipairs(lspconfig.get_installed_servers()) do
            vim.lsp.config(server, {
                capabilities = capabilities,
            })
        end
    end,
}
