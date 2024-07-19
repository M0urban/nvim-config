require('lazy').setup({

  --git related plugins
  --check if vim-rhubarb for gh integration is good
  'tpope/vim-fugitive',

  -- lsp related stuff order here is required according to mason-lspconfig
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  -- "Automatically configures lua-language-server for your Neovim config, Neovim runtime and plugin directories"
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        -- Only load the lazyvim library when the `LazyVim` global is found
        { path = "LazyVim",            words = { "LazyVim" } },
        -- Load the wezterm types when the `wezterm` module is required
        -- Needs `justinsgithub/wezterm-types` to be installed
        { path = "wezterm-types",      mods = { "wezterm" } },
        { path = "nvim-dap-ui",        mods = { "nvim-dap-ui" } },
      },
      -- always enable unless `vim.g.lazydev_enabled = false`
      -- This is the default
      enabled = function(root_dir)
        return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
      end,
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
  -- "Extensible UI for Neovim notifications and LSP progress messages."
  { 'j-hui/fidget.nvim',    opts = {} },

  -- show pending keybindings
  { 'folke/which-key.nvim', opts = {} },
  {
    'lewis6991/gitsigns.nvim',

    opts = {
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end
    }
  },
  {  -- optional completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  { "L3MON4D3/LuaSnip",                    run = "make install_jsregexp" },
  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      --Adds completion for / or ? searches
      'hrsh7th/cmp-buffer',
      -- Adds completion capabilities for : and terminal
      -- 'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-cmdline',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },
  --Add guides for indentation
  { "lukas-reineke/indent-blankline.nvim", main = "ibl",                 opts = {} },

  -- gb and gc for regions/lines/text objects
  { 'numToStr/Comment.nvim',               opts = {} },
  -- statusline
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        icons_enabled = false,
        theme = 'molokai',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.6',
    branch = '0.1.x',
    dependencies = {
      --requirement for  telescope
      'nvim-lua/plenary.nvim',
      -- fzf is a fuzzy-find alghorythm for telescope, build if not available
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
    }
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- allows creating own textobjects
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  -- colorscheme
  {
    'tanvirtin/monokai.nvim',
    priority = 1000,
    config = function()
      local monokai = require('monokai')
      local palette = monokai.classic
      monokai.setup {
        custom_hlgroups = {
          LineNr = {
            fg = palette.grey,
          },
          CursorLineNr = {
            fg = palette.orange,
          },
        },

      }
    end,
  },

  -- latex integration
  {
    'lervag/vimtex',
    init = function()
      vim.g.vimtex_view_method = 'general'
      vim.g.vimtex_view_general_viewer = 'SumatraPDF'
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      -- vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.maplocalleader = '\\'
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  -- debugging
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- debugger ui
      'rcarriga/nvim-dap-ui',
      "nvim-neotest/nvim-nio",

      -- Installation and Integration of daps
      'williamboman/mason.nvim',
      -- 'jay-babu/mason-nvim-dap.nvim',

    },
    config = function()
      require('config.debug-config').dap_config()
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'Civitasv/cmake-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = require('config.cmake-tools-config').cmake_config,
  },
  {
    'b0o/SchemaStore.nvim',
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'ggandor/leap.nvim',
    dependencies = {
      'tpope/vim-repeat',
    },
    lazy = false,
  },
})
