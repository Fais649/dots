require 'plugins.options'
require 'plugins.keymaps'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.whichkey',
  require 'plugins.autofmt',
  require 'plugins.nvim-cmp',
  require 'plugins.themes',
  require 'plugins.todo',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.ts-autotag',
  require 'plugins.git',
  require 'plugins.lint',
  require 'plugins.pio',
  require 'plugins.sshfs',
  require 'plugins.lsp',
  require 'plugins.telescope',
  require 'plugins.harpoon',
  require 'plugins.suda',
  require 'plugins.refactor',
  require 'plugins.yazi',
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '⚙',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = 'zzz',
    },
  },
})
require 'plugins.cmd'
