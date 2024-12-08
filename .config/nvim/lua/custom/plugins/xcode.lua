return {
  'wojciech-kulik/xcodebuild.nvim',
  -- enabled = false,
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('xcodebuild').setup {}
    vim.keymap.set({ 'n', 'v', 't' }, '<leader>xx', ':XcodebuildBuildRun<CR> <BAR>  :lua require("dapui").toggle()<CR>',
      { desc = 'Xcode Build & Run' })
    vim.keymap.set({ 'n', 'v', 't' }, '<leader>xc', ' :lua require("dapui").toggle()<CR>', { desc = 'Xcode Build & Run' })
  end,
}
