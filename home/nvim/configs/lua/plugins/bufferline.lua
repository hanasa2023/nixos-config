return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  opts = {
    options = {
      always_show_bufferline = true,
      numbers = "ordinal",
      -- buffer_close_icon = "",
      -- modified_icon = "●",
      -- close_icon = "",
      -- left_trunc_marker = "",
      -- right_trunc_marker = "",
      -- max_name_length = 18,
      -- max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      -- tab_size = 20,
      offsets = {
        {
          filetype = "neo-tree",
          text = "󰴈 Hanasaki",
          highlight = "Directory",
          text_align = "center",
          spearator = false,
        },
      },
    },
  },
}
