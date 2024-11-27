require("neo-tree").setup({
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
    }
  },
  filesystem = {
    hijack_netrw_behavior = "open_current", --set "disabled"
    use_libuv_file_watcher = true,
  },
  source_selector = {
    content_layout = "center",
    tabs_layout = "center",
  },
  buffers = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
  },
  event_handlers = {
    {
      event = "neo_tree_buffer_enter",
      handler = function(arg)
        vim.cmd([[
              setlocal relativenumber
            ]])
      end,
    },
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

vim.keymap.set('n', '<leader>fs',
  function()
    require("neo-tree.command").execute({
      toggle = true,
      position = "left",
    })
  end,
  { desc = "Buffers (root dir)" })
