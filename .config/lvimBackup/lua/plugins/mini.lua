return {
  {
    "echasnovski/mini.surround",
    version = "*",
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 500,

      -- Module mappings. Usng) to disable one.
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = "cover",

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = {
      hide_target_hack = false,
      cursor_color = "none",
    },
    specs = {
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
  {
    "echasnovski/mini.animate",
    optional = true,
    enabled = false,
    config = function()
      local animate = require("mini.animate")
      local opts = {
        cursor = {
          enable = false,
          timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
          enable = false,
          timing = animate.gen_timing.linear({ duration = 20, unit = "total" }),
          --
          subscroll = animate.gen_subscroll.equal({ max_output_steps = 30 }),
        },
        resize = {
          enable = false,
        },
        open = {
          enable = false,
        },
        close = {
          enable = false,
        },
      }

      animate.setup(opts)
    end,
  },
}
