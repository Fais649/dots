return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    local animate = require 'mini.animate'
    require('mini.ai').setup { n_lines = 500 }
    require('mini.jump').setup { n_lines = 500 }
    -- require('mini.files').setup()
    require('mini.move').setup()
    require('mini.clue').setup()
    require('mini.bufremove').setup()
    require('mini.bracketed').setup()
    require('mini.icons').setup()
    require('mini.pairs').setup()
    -- require('mini.tabline').setup()
    require('mini.starter').setup()
    animate.setup {
      cursor = {
        -- Whether to enable this animation
        enable = false,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Path generator for visualized cursor movement
        -- path = --<function: implements shortest line path>,
      },

      -- Vertical scroll
      scroll = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        timing = animate.gen_timing.linear { duration = 50, unit = 'total' },

        -- Animate equally but with at most 120 steps instead of default 60
        subscroll = animate.gen_subscroll.equal { max_output_steps = 180 },
      },

      -- Window resize
      resize = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Subresize generator for all steps of resize animations
        -- subresize = --<function: implements equal linear steps>,
      },

      -- Window open
      open = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Floating window config generator visualizing specific window
        -- winconfig = --<function: implements static window for 25 steps>,

        -- 'winblend' (window transparency) generator for floating window
        -- winblend = --<function: implements equal linear steps from 80 to 100>,
      },

      -- Window close
      close = {
        -- Whether to enable this animation
        enable = true,

        -- Timing of animation (how steps will progress in time)
        -- timing = --<function: implements linear total 250ms animation duration>,

        -- Floating window config generator visualizing specific window
        -- winconfig = --<function: implements static window for 25 steps>,

        -- 'winblend' (window transparency) generator for floating window
        -- winblend = --<function: implements equal linear steps from 80 to 100>,
      },
    }

    require('mini.surround').setup {
      custom_surroundings = nil,
      highlight_duration = 500,
      mappings = {
        add = '<leader>sa', -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd', -- Delete surrounding
        find = '<leader>sf', -- Find surrounding (to the right)
        find_left = '<leader>sF', -- Find surrounding (to the left)
        highlight = '<leader>sh', -- Highlight surrounding
        replace = '<leader>sr', -- Replace surrounding
        update_n_lines = '<leader>sn', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
      n_lines = 20,
      respect_selection_type = false,
      search_method = 'cover',
      silent = false,
    }

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
