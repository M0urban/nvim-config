local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>o", function() harpoon:list():add() end, {desc = 'Add current file to harpoon'})
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc = 'Show harpooned files'})

vim.keymap.set("n", "<C-t>", function() harpoon:list():select(1) end, {desc = 'Harpoon slot 1'})
vim.keymap.set("n", "<C-z>", function() harpoon:list():select(2) end, {desc = 'Harpoon slot 2'})
vim.keymap.set("n", "<C-b>", function() harpoon:list():select(3) end, {desc = 'Harpoon slot 3'})
vim.keymap.set("n", "<C-n>", function() harpoon:list():select(4) end, {desc = 'Harpoon slot 4'})

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<leader>p", function() harpoon:list():prev() end, {desc = 'Previous harpoon buffer'})
vim.keymap.set("n", "<leader>n", function() harpoon:list():next() end, {desc = 'Next harpoon buffer'})
