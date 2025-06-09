return -- LSP keymaps
{
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    -- add a keymap
    keys[#keys + 1] = {
      "H",
      function()
        return vim.lsp.buf.hover()
      end,
      desc = "Hover",
    }
    opts.servers.clangd = {
      mason = false,
      cmd = { "/etc/profiles/per-user/hanasaki/bin/clangd" },
    }
  end,
}
