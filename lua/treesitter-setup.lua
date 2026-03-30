-- [[ Configure Tree-sitter ]]
-- See `:help nvim-treesitter`
-- Defer Tree-sitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  if (require('helpers.os').isWindows()) then
    require('nvim-treesitter.install').compilers = { "clang", "zig", "gcc" }
  end
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for Tree-sitter
    ensure_installed = { 'c', 'cpp', 'cmake', 'gitignore', 'go', 'json', 'jsonc', 'json5', 'lua', 'python',
      'rust', 'vimdoc', 'vim', 'bash', 'xml', 'yaml', 'zig', 'markdown', 'markdown_inline', 'doxygen', 'printf' },

    -- Auto install languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-A-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to text object, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          -- s for struct
          ['as'] = '@class.outer',
          ['is'] = '@class.inner',
          ['ac'] = '@comment.outer',
          ['ic'] = '@comment.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- Whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>ap'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>AP'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)
