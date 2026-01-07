local M = {}

function M.cmake_config()
  local procs = vim.loop.cpu_info()
  -- If number of processes cannot be found use 8 as default.
  local num_of_procs = 8
  if not (procs == nil) then
    local count = 0
    for _ in pairs(procs) do count = count + 1 end
    if count > 0 then
      num_of_procs = count
    end
  end

  local num_of_procs_option = string.format("-j%d", num_of_procs)
  require('cmake-tools').setup {
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
    cmake_build_options = {num_of_procs_option},                                         -- this will be passed when invoke `CMakeBuild`
    -- support macro expansion:
    --       ${kit}
    --       ${kitGenerator}
    --       ${variant:xx}
    cmake_build_directory = "build",-- "build/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
    cmake_soft_link_compile_commands = true,          -- this will automatically make a soft link from compile commands file to project root dir
    cmake_executor = {
      default_opts = {
        quickfix = {
          auto_close_when_success = true,
        },
      },
    },
  }
end

return M
