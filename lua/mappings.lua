require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })   -- split window vertically
map("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- search key
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "sh", "<cmd>:vertical resize -5<CR>")
map("n", "sk", "<cmd>:resize -5<CR>")
map("n", "sj", "<cmd>:resize +5<CR>")
map("n", "sl", "<cmd>:vertical resize +5<CR>")

map("n", "ss", ":split<Return>")

-- telescope todo list
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Find todos" })
