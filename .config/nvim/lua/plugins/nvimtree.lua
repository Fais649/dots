return {
  {
    'mikew/nvim-drawer',
    opts = {},
    config = function(_, opts)
      local drawer = require 'nvim-drawer'
      drawer.setup(opts)

      drawer.create_drawer {
        -- This is needed for nvim-tree.
        nvim_tree_hack = true,

        -- Position on the right size of the screen.
        -- position = 'left',
        -- size = 40,

        -- -- Alternatively, you can have it floating.
        size = 40,
        position = 'float',
        win_config = {
          margin = 2,
          border = 'rounded',
          anchor = 'NW',
          width = 40,
          height = '80%',
        },
        --
        on_vim_enter = function(event)
          -- - Open the drawer on startup.
          -- event.instance.open {
          --   focus = true,
          -- }

          --- Example mapping to toggle.
          vim.keymap.set('n', '<F1>', function()
            event.instance.focus_or_toggle()
          end)
          vim.keymap.set('n', '<esc>', function()
            event.instance.close()
          end)
        end,

        --- Ideally, we would just call this here and be done with it, but
        --- mappings in nvim-tree don't seem to apply when re-using a buffer in
        --- a new tab / window.
        on_did_create_buffer = function()
          local nvim_tree_api = require 'nvim-tree.api'
          nvim_tree_api.tree.open { current_window = true }
        end,

        --- This gets the tree to sync when changing tabs.
        on_did_open = function()
          local nvim_tree_api = require 'nvim-tree.api'
          nvim_tree_api.tree.reload()

          vim.opt_local.number = false
          vim.opt_local.signcolumn = 'no'
          vim.opt_local.statuscolumn = ''
        end,

        --- Cleans up some things when closing the drawer.
        on_did_close = function()
          local nvim_tree_api = require 'nvim-tree.api'
          nvim_tree_api.tree.close()
        end,
      }
    end,
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
        hijack_cursor = true,
        hijack_netrw = true,
        update_cwd = true,
        sync_root_with_cwd = true,
      }

      vim.api.nvim_create_autocmd('BufEnter', {
        nested = true,
        callback = function()
          if #vim.api.nvim_list_wins() == 1 and require('nvim-tree.utils').is_nvim_tree_buf() then
            vim.cmd 'quit'
          end
        end,
      })
    end,
  },
}
