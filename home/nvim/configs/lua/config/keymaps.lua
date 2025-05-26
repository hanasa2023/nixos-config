-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap

map.set({ "n", "x" }, "J", "5j", { desc = "Quick down" })
map.set({ "n", "x" }, "K", "5k", { desc = "Quick up" })
map.set("n", ";", ":", { desc = "Open panel" })
map.set("n", "S", "<cmd>w<cr>", { desc = "Save file" })
map.set("n", "Q", "<cmd>q<cr>", { desc = "Exit file" })
map.set("n", "<leader>T", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open float term" })
map.set("n", "<A-3>", "<cmd>ToggleTerm direction=float<cr>", { desc = "Open float term" })
map.set("n", "<leader><cr>", "<cmd>nohl<cr>", { desc = "nohl" })
-- map.set("n", "<leader>h", "<cmd>ToggleTerm<cr>", { desc = "Open horizontal term" })

map.set({ "i", "x" }, "jj", "<esc>", { desc = "Replace esc" })

map.set("n", "<leader>ce", "<cmd>RunCpp<cr>", { desc = "Run Cpp" })
