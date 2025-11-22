return {
    {
        'ellisonleao/gruvbox.nvim',
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- load the colorscheme here
            vim.cmd.colorscheme 'gruvbox'

            vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#504945' })
            vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#504945' })
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#504945' })
        end,
    },
}
