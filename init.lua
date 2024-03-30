-- Set  leader keys
vim.g.mapleader = ' '
vim.g.localleader = '\\'

-- install lazy plugin manager
require('lazy-bootstrap')

-- list plugins and do minmal config
require('plugins')

-- non-plugin options
require('options')

-- keymap
require('keymaps')

-- auto commands
require('autocmd')

-- fuzy finder
require('telescope-setup')

-- treesitter
require('treesitter-setup')

-- lsp stuff
require('lsp-setup')

-- autocomplete and smippets
require('nvim-cmp-setup')

-- different plugin configs
require('plugin-config')
