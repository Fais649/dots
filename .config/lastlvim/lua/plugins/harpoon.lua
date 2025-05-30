return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
  keys = function()
    local keys = {
      {
        '<leader>h',
        function()
          require('harpoon'):list():add()
        end,
        desc = 'Harpoon File',
      },
      {
        '<leader>^',
        function()
          local harpoon = require 'harpoon'
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon Quick Menu',
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        '<leader>' .. i,
        function()
          require('harpoon'):list():select(i)
        end,
        desc = 'Harpoon to File ' .. i,
      })
    end
    return keys
  end,
  default = {
    get_root_dir = function()
      local cwd = vim.loop.cwd()
      local root = vim.fn.system 'git rev-parse --show-toplevel'
      if root ~= nil then
        return string.gsub(root, '\n', '')
      end
      return cwd
    end,
  },
}
