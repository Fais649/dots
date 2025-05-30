--
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("n", "<leader><Tab>", "<C-^>", { desc = "Previous Buffer" })
vim.keymap.set({ "n", "v", "t" }, "{", "10j", { desc = "10 Lines Down" })
vim.keymap.set({ "n", "v", "t" }, "}", "10k", { desc = "10 Lines Up" })
vim.keymap.set({ "n", "v", "t" }, "-", "]m", { desc = "]{" })
vim.keymap.set({ "n", "v", "t" }, "+", "[m", { desc = "[{" })
vim.keymap.set({ "n", "v", "t", "o" }, "<Tab>", "%", { desc = "Jump Closure" })
vim.keymap.set({ "n", "v" }, "V", "Vlh", { desc = "Visual Line" })
vim.keymap.set({ "n", "v" }, "v", "vlh", { desc = "Visual Line" })
-- vim.keymap.set({ "n", "v", "t", "i" }, "<M-left>", "<C-left>", { desc = "go left" })
-- vim.keymap.set({ "n", "v", "t", "i" }, "<M-right>", "<C-right>", { desc = "go right" })

vim.keymap.set({ "n", "v" }, "0", "$", { desc = "End of Line" })

vim.keymap.set({ "n", "v", "t", "i" }, "<F1>", ":Yazi <CR>", { desc = "File Explorer" })
vim.keymap.set({ "n", "v", "t", "i" }, "<F2>", ":FzfLua files resume=true <CR>", { desc = "Files" })
vim.keymap.set({ "n", "v", "t", "i" }, "<F3>", ":FzfLua live_grep_resume <CR>", { desc = "Live Grep" })

vim.keymap.set({ "n", "v", "t", "i" }, "<A-b>", "<S-left>", { desc = "go left" })
vim.keymap.set({ "n", "v", "t", "i" }, "<A-f>", "<S-right>", { desc = "go right" })
vim.keymap.set({ "n", "v", "t", "i" }, "<M-left>", "<S-left>", { desc = "go left" })
vim.keymap.set({ "n", "v", "t", "i" }, "<M-right>", "<S-right>", { desc = "go right" })

-- vim.keymap.set({ "t", "i" }, "<A-l>", "<right>", { desc = "go right" })
-- vim.keymap.set({ "t", "i" }, "<A-k>", "<up>", { desc = "go up" })
-- vim.keymap.set({ "t", "i" }, "<A-j>", "<down>", { desc = "go down" })
-- vim.keymap.set({ "t", "i" }, "<A-h>", "<left>", { desc = "go left" })

-- vim.keymap.set({ "n", "v", "t", "i" }, "<A-i>", ":", { desc = ":" })
-- vim.keymap.set({ "n", "v", "t", "i" }, "<A-f>", "/", { desc = "/" })
-- vim.keymap.set({ "n", "v", "t", "i" }, "<A-w>", "ciw", { desc = "change in word" })
-- vim.keymap.set({ "n", "v", "t", "i" }, "<A-q>", "ciq", { desc = "change in quote" })

vim.keymap.set({ "n", "v" }, "<leader>fm", function()
  require("conform").format({ async = true }, function(err)
    if not err then
      local mode = vim.api.nvim_get_mode().mode
      if vim.startswith(string.lower(mode), "v") then
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
      end
    end
  end)
end, { desc = "Format code" })

-- vim.keymap.set({ "n", "v" }, "<leader><leader>", ":ZenMode<CR>", { desc = "Toggle ZenMode" })
-- vim.keymap.set({ "n", "v" }, "<leader>td", ":ObsidianToday<CR>", { desc = "Go to Today" })

vim.keymap.set({ "n", "v" }, "<leader>rn", vim.lsp.buf.rename)
