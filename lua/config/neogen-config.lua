local M = {}
function M.neogen_setup()
  require('neogen').setup({
    snippet_engine = "luasnip",
  })
end

return M
