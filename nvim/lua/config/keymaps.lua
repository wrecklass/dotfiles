-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap -- shortcut
local cmd = vim.cmd -- shortcut

vim.g.mapleader = " "

keymap.set("n", "<leader>vv", ':h <C-R>=expand("<cword>")<CR><CR>', { desc = "Vim help at at touch of two buttons" })
keymap.set("n", "Q", "<nop>", { desc = "Avoid Q taking us to macro hell" })

keymap.set("n", "n", "nzzzv", { desc = "Move to next search result and center line" })
keymap.set("n", "N", "Nzzzv", { desc = "Move to prev search result and center line" })
