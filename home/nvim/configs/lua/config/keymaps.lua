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

-- flutter
map.set("n", "<leader>'r", "<cmd>FlutterRun<cr>", { desc = "Run the current project" })
map.set("n", "<leader>'R", "<cmd>FlutterRestart<cr>", { desc = "Restart the current project" })
map.set("n", "<leader>'hr", "<cmd>FlutterReload<cr>", { desc = "Reload the running project." })
map.set("n", "<leader>'q", "<cmd>FlutterQuit<cr>", { desc = "Ends a running session." })
map.set("n", "<leader>'s", "<cmd>FlutterDevices<cr>", { desc = "Brings up a list of connected devices to select from" })
map.set("n", "<leader>'a", "<cmd>FlutterAttach<cr>", { desc = "Attach to a running app" })
map.set("n", "<leader>'d", "<cmd>FlutterDetach<cr>", { desc = "Ends a running session locally" })
map.set("n", "<leader>'D", "<cmd>FlutterDevTools<cr>", { desc = "Starts a Dart Dev Tools server" })
map.set("n", "<leader>'t", "<cmd>FlutterOutlineToggle<cr>", { desc = "Flutter Outline Toggle" })
