vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

vim.keymap.set({ 'n', 'v', 'i', 't' }, '<f12>', '<cmd>ToggleTerm direction=horizontal<CR>', { desc = 'Toggle Terminal' })
-- vim.keymap.set({ 'n', 'v', 'i', 't' }, '<f1>', '<cmd>lua MiniFiles.open()<CR>', { desc = '' })

vim.keymap.set({ 'n', 'v' }, '{', '10j', { desc = '5 Lines Down' })
vim.keymap.set({ 'n', 'v' }, '}', '10k', { desc = '5 Lines Up' })
vim.keymap.set({ 'n', 'v' }, '-', '20j', { desc = '10 Lines Down' })
vim.keymap.set({ 'n', 'v' }, '+', '20k', { desc = '10 Lines Up' })

vim.keymap.set('n', '<leader><Tab>', '<C-^>')

vim.keymap.set({ 'n', 'i' }, '<A-j>', 'ddp', { desc = 'Move Line Down' })
vim.keymap.set({ 'n', 'i' }, '<A-k>', 'ddkP', { desc = 'Move Line Up' })

-- vim.keymap.set('n', '<TAB>', '<cmd>bnext<CR>', { desc = 'Next Tab' })
-- vim.keymap.set('n', '<S-TAB>', '<cmd>bprevious<CR>', { desc = 'Last Tab' })

vim.keymap.set('n', '<A-l>', '>>', { desc = 'Indent ->' })
vim.keymap.set('n', '<A-h>', '<<', { desc = 'Indent <-' })
vim.keymap.set({ 'n' }, '<Esc>', '<cmd>noh <CR>', { desc = 'Escape and Clear hlsearch' })

vim.keymap.set('n', '<A-left>', '<C-o>', { desc = 'Go Back' })
vim.keymap.set('n', '<A-right>', '<C-i>', { desc = 'Go Forward' })

vim.keymap.set('x', '<leader>re', ':Refactor extract ')
vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ')
vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ')
vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var')
vim.keymap.set('n', '<leader>rI', ':Refactor inline_func')
vim.keymap.set('n', '<leader>rb', ':Refactor extract_block')
vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file')

vim.keymap.set('n', '<leader>.', '<C-w>w')
