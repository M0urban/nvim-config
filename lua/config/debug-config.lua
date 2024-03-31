local M = {}

local lldb_rust

function M.dap_config()
  local dap = require('dap')
  local dapui = require('dapui')

  --[[ require('mason-nvim-dap').setup  {
    --trys setting reasonable default configs
    automatic_setup = true,

    handlers = {
      function(config)
        -- all sources with no handler get passed here

        -- Keep original functionality
        require('mason-nvim-dap').default_setup(config)
      end,
      rust = function(config)
        dap.adapters.lldb = {
          type = 'executable',
          command = 'C:/Program Files/LLVM/clang+llvm-18.1.2-x86_64-pc-windows-msvc/bin/lldb-dap.exe', -- adjust as needed, must be absolute path
          -- command = '/usr/bin/lldb-dap, alternative for linux
          name = 'lldb'
        }
        require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,
      python = function(config)
        config.adapters = {
          type = "executable",
          command = "/usr/bin/python3",
          args = {
            "-m",
            "debugpy.adapter",
          },
        }
        require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,
    },

    ensure_installed = {
      --insert dap's here
    },
  } ]]

  --basic keymaps
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  dapui.setup {
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close
  -- prepare rust debuger
  require('config.rust-debug')
end

function lldb_cpp()
  local dap = require('dap')
  -- First set up adapter
  dap.adapters.lldb = {
    type = 'executable',
    command = 'C:/Program Files/LLVM/clang+llvm-18.1.2-x86_64-pc-windows-msvc/bin/lldb-dap.exe', -- adjust as needed, must be absolute path
    -- command = '/usr/bin/lldb-dap, alternative for linux
    name = 'lldb'
  }

  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      args = {},

      -- 💀
      -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
      --
      --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      --
      -- Otherwise you might get the following error:
      --
      --    Error on launch: Failed to attach to the target process
      --
      -- But you should be aware of the implications:
      -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
      -- runInTerminal = false,
    },
  }
end

return M
