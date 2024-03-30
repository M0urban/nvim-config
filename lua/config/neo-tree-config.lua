--[[ require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
    }
  },
}) ]]

vim.keymap.set('n', '<leader>ft',
  function()
    require("neo-tree.command").execute({
      toggle = true,
      position = "current",
    })
  end,
  { desc = "Buffers (root dir)" })
