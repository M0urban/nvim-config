-- [[Basic non Plugin Keymap]]

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>h', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {desc = "Toggle inlay hints"})

-- Usefull remaps
vim.keymap.set('n', '<leader>rw', vim.cmd.Ex)
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')


-- Some yank, delete, change and put binds
vim.keymap.set({ 'n', 'v' }, '<leader>vc', '"_c', { desc = '[c]hange to [v]oid register' })
vim.keymap.set({ 'n', 'v' }, '<leader>vC', '"_C', { desc = '[C]hange line to [v]oid register' })
vim.keymap.set({ 'n', 'v' }, '<leader>vd', '"_d', { desc = '[d]elete to [v]oid register' })
vim.keymap.set({ 'n', 'v' }, '<leader>vD', '"_D', { desc = '[D]elete line to [v]oid register' })

vim.keymap.set({ 'n', 'v' }, '<leader>Cy', '"+y', { desc = '[C]lipboard [y]ank' })
vim.keymap.set({ 'n', 'v' }, '<leader>CY', '"+Y', { desc = '[C]lipboard [Y]ank' })
vim.keymap.set({ 'n', 'v' }, '<leader>Cc', '"+c', { desc = '[C]lipboard [c]hange' })
vim.keymap.set({ 'n', 'v' }, '<leader>CC', '"+C', { desc = '[C]lipboard [C]hange' })
vim.keymap.set({ 'n', 'v' }, '<leader>Cd', '"+d', { desc = '[C]lipboard [d]elete' })
vim.keymap.set({ 'n', 'v' }, '<leader>CD', '"+D', { desc = '[C]lipboard [D]elete' })
vim.keymap.set({ 'n', 'v' }, '<leader>Cp', '"+p', { desc = '[C]lipboard [p]ut' })
vim.keymap.set({ 'n', 'v' }, '<leader>CP', '"+P', { desc = '[C]lipboard [P]ut' })
-- vim: ts=2 sts=2 sw=2 et
