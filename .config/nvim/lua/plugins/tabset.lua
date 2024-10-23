return {
  'FotiadisM/tabset.nvim',
  config = function()
    require('tabset').setup {
      defaults = {
        tabwidth = 4,
        expandtab = true,
      },
      languages = {
        go = {
          tabwidth = 4,
          expandtab = false,
        },
        {
          filetypes = { 'svelte', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'json', 'yaml' },
          config = {
            tabwidth = 2,
          },
        },
      },
    }
  end,
}
