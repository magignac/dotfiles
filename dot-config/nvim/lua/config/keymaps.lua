local keymap = vim.keymap

-- remove default vim LSP mappings
keymap.del('n', 'grt')
keymap.del('n', 'gri')
keymap.del({'n', 'x'}, 'gra')
keymap.del('n', 'grr')
keymap.del('n', 'grn')

keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle file explorer' })
keymap.set('n', '<leader>N', '<cmd>NvimTreeFindFile<CR>', { desc = 'Open file explorer on current file' })

keymap.set('n', '<leader>ff', '<cmd>Telescope find_files find_command=rg,--files<CR>', { desc = 'Fuzzy find files in cwd' })
keymap.set('n', '<leader>fF', '<cmd>Telescope find_files find_command=rg,--hidden,--ignore,--files<CR>', { desc = 'Fuzzy find files (including hidden) in cwd' })
keymap.set('n', '<leader>f<leader>', '<cmd>Telescope oldfiles<cr>', { desc = 'Fuzzy find recent files' })
keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<CR>', { desc = 'Find in buffers' })
keymap.set('n', '<leader>f:', '<cmd>Telescope command_history<CR>', { desc = 'Find in command history' })
keymap.set('n', '<leader>f/', '<cmd>Telescope search_history<CR>', { desc = 'Find in search history' })
keymap.set('n', '<leader>fm', '<cmd>Telescope marks<CR>', { desc = 'Find in marks' })
keymap.set('n', '<leader>fr', '<cmd>Telescope registers<CR>', { desc = 'Find in registers' })
keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', { desc = 'Fuzzy find word' })
keymap.set('n', '<leader>fG', '<cmd>Telescope grep_string<cr>', { desc = 'Find string under cursor in cwd' })
keymap.set('n', '<leader>fl', '<cmd>Telescope jumplist<CR>', { desc = 'Find in jumplist' })

keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', { desc = 'Show buffer diagnostics' })
keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { desc = 'Show LSP references', remap = true })
keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show documentation for what is under cursor' })

-- TODO telescope git related
--   <leader>gg git files
--   <leader>gb git branches
--   <leader>gc git commits
--   <leader>gm files from master (get main branch name from git config?)

-- TODO telescope find from nvim-tree
--   limit search to the selected directory
