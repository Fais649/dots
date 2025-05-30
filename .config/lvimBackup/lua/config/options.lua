-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- vim.cmd.colorscheme("kanagawa")

vim.cmd.hi("Visual ctermbg=236 guifg=#aaaaaa guibg=#323232")
vim.cmd.hi("Visual guibg=#323232")

vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,list:full" -- don't insert, show options
