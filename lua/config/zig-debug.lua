local dap = require('dap')


dap.configurations.zig = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '\\zig-out\\bin\\', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
