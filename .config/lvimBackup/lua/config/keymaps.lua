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
vim.keymap.set({ "n", "v", "t" }, "V", "Vlh", { desc = "Visual Line" })
vim.keymap.set({ "n", "v", "t" }, "v", "vlh", { desc = "Visual Line" })
vim.keymap.set({ "n", "v", "t", "i" }, "<A-left>", "<C-left>", { desc = "go left" })
vim.keymap.set({ "n", "v", "t", "i" }, "<A-right>", "<C-right>", { desc = "go right" })
vim.keymap.set({ "n", "v", "t", "i" }, "<M-left>", "<C-left>", { desc = "go left" })
vim.keymap.set({ "n", "v", "t", "i" }, "<M-right>", "<C-right>", { desc = "go right" })
vim.keymap.set({ "n", "v" }, "0", "$", { desc = "End of Line" })

vim.keymap.set({ "n", "v", "t", "i" }, "<F1>", ":Yazi <CR>", { desc = "go right" })

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

vim.keymap.set({ "n", "v" }, "<leader><leader>", ":ZenMode<CR>", { desc = "Toggle ZenMode" })
vim.keymap.set({ "n", "v" }, "<leader>td", ":ObsidianToday<CR>", { desc = "Go to Today" })
