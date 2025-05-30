return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        llama3 = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "llama3.2", -- Give this adapter a different name to differentiate it from the default ollama adapter
            schema = {
              model = {
                default = "llama3.2:latest",
              },
              num_ctx = {
                default = 16384,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
      },
    })

    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          schema = {
            model = {
              default = "llama3.2:latest",
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
          keymaps = {
            send = {
              modes = {
                n = { "<CR>" },
                i = { "<CR>" },
              },
            },
          },
        },
        inline = {
          adapter = "ollama",
          schema = {
            model = {
              default = "llama3.2:latest",
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
        },
      },
    })
    vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end,
}
