require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
    }
  },
  filesystem = {
    hijack_netrw_behavior = "open_current", --set "disabled"
  },
  source_selector = {
    content_layout = "center",
    tabs_layout = "center",
  },
})

vim.keymap.set('n', '<leader>ft',
  function()
    require("neo-tree.command").execute({
      toggle = true,
      position = "current",
    })
  end,
  { desc = "Buffers (root dir)" })
