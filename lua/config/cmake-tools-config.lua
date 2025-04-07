local M = {}

function M.cmake_config()
  require('cmake-tools').setup {
    cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" }, -- this will be passed when invoke `CMakeGenerate`
    cmake_build_options = {"-j$(nproc)"},                                         -- this will be passed when invoke `CMakeBuild`
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
