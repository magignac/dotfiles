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

keymap.set('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<CR>', { desc = 'Show buffer diagnostics' })
keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics<CR>', { desc = 'Show all diagnostics' })
keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { desc = 'Show LSP references', remap = true })
keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show documentation for what is under cursor' })
keymap.set({'n','x'}, 'ga', vim.lsp.buf.code_action, { desc = 'Code action' })
keymap.set({'n', 'x'}, 'gd', vim.lsp.buf.definition, { desc = 'Definition' })

keymap.set('n', '[g', '<cmd>Gitsigns prev_hunk<CR>', { desc = 'Previous diff hunk' })
keymap.set('n', ']g', '<cmd>Gitsigns next_hunk<CR>', { desc = 'Next diff hunk' })

keymap.set('n', '[<C-d>', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic' })
keymap.set('n', ']<C-d>', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })

keymap.set('n', '<leader>gg', '<cmd>Telescope git_status<CR>', { desc = 'Git files' })
keymap.set('n', '<leader>gb', '<cmd>Telescope git_branches<CR>', { desc = 'Git branches' })
keymap.set('n', '<leader>gc', '<cmd>Telescope git_commits<CR>', { desc = 'Git commits' })
keymap.set('n', '<leader>gm', function()
  local branch = 'main'
  if vim.fn.system('git rev-parse origin/main 2>/dev/null'):len() == 0 then
    branch = 'master'
  end
  local files = vim.fn.system('git diff --name-only ' .. branch .. '...HEAD')
  local file_list = {}
  for file in files:gmatch('[^\n]+') do
    if file ~= '' then
      table.insert(file_list, file)
    end
  end

  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local conf = require('telescope.config').values

  pickers.new({}, {
    finder = finders.new_table({ results = file_list }),
    sorter = conf.generic_sorter({}),
    previewer = conf.file_previewer({}),
  }):find()
end, { desc = 'Files changed from main/master branch' })

-- NOTE: telescope find from nvim-tree with directory limiting requires custom command
-- using nvim-tree API to get the selected node and its path. Can be added to
-- nvim-tree config callback if needed.
