local dap = require('dap')
-- figure out lldb path
local lldbpath =  (vim.fn.stdpath('data') .. '/mason' .. '/packages' .. '/codelldb' .. '/extension' .. '/adapter' .. '/codelldb.exe')
-- print(lldbpath)
--register adapter
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    -- CHANGE THIS to your path!
    command = lldbpath,
    args = {"--port", "${port}"},

    -- On windows you may have to uncomment this:
    -- detached = false,
  }
}

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
