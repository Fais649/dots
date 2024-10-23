return {
  'roobert/tabtree.nvim',
  config = function()
    require('tabtree').setup {

      key_bindings = {
        next = '<Tab>',
        previous = '<S-Tab>',
      },
    }
  end,
}
