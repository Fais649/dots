return {
  "nvim-telescope/telescope.nvim",
  enabled = true,
  defaults = {
    theme = "dropdown",
  },
  keys = {
    { "<leader><leader>", false },
    -- { "<F2>", ":Telescope find_files theme=dropdown<cr>", desc = "Find Files" },
    -- { "<F3>", ":Telescope live_grep theme=dropdown<cr>", desc = "Find Files" },
    -- { "<F4>", ":Telescope lsp_dynamic_workspace_symbols theme=dropdown<CR>", desc = "Find Symbols" },
    -- { "<F5>", ":Telescope git_status theme=dropdown<CR>", desc = "Find Changed Files" },
    -- { "<F6>", ":Telescope git_branches theme=dropdown<CR>", desc = "Find Changed Files" },
    -- add a keymap to browse plugin files
    {
      "<leader>fp",
      function()
        require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
      end,
      desc = "Find Plugin File",
    },
  },
}
