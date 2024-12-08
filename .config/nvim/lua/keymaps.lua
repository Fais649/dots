-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et

vim.cmd.hi 'Visual ctermbg=236 guifg=#aaaaaa guibg=#323232'
vim.cmd.hi 'Visual guibg=#323232'
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader><Tab>', '<C-^>', { desc = 'Previous Buffer' })
vim.keymap.set({ 'n', 'v', 't' }, '{', '10j', { desc = '10 Lines Down' })
vim.keymap.set({ 'n', 'v', 't' }, '}', '10k', { desc = '10 Lines Up' })
vim.keymap.set({ 'n', 'v', 't' }, '-', '20j', { desc = '20 Lines Down' })
vim.keymap.set({ 'n', 'v', 't' }, '+', '20k', { desc = '20 Lines Up' })
vim.keymap.set({ 'n', 'v', 't' }, '<Tab>', '%', { desc = 'Jump Closure' })
vim.keymap.set({ 'n', 'v', 't' }, 'va<Tab>', '%', { desc = 'Jump Closure' })
vim.keymap.set({ 'n', 'v', 't' }, 'V', 'Vlh', { desc = 'Visual Line' })
vim.keymap.set({ 'n', 'v', 't' }, 'v', 'vlh', { desc = 'Visual Line' })
vim.keymap.set({ 'n', 'v', 't', 'i' }, '<A-left>', '<C-left>', { desc = 'go left' })
vim.keymap.set({ 'n', 'v', 't', 'i' }, '<A-right>', '<C-right>', { desc = 'go right' })
vim.keymap.set({ 'n', 'v', 't', 'i' }, '<M-left>', '<C-left>', { desc = 'go left' })
vim.keymap.set({ 'n', 'v', 't', 'i' }, '<M-right>', '<C-right>', { desc = 'go right' })

vim.keymap.set({ 'n', 'v', 't', 'i' }, '<F1>', ':Yazi', { desc = 'go right' })
