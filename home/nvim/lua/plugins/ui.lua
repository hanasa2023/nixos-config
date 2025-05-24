return {
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.cursorword").setup()
    end,
    keys = {},
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup({
        show_in_active_only = true,
        handlers = {
          gitsigns = true,
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    optional = true,
    -- opts = function(_, opts)
    --   table.insert(opts.sections.lualine_x, 2, LazyVim.lualine.cmp_source("codeium"))
    --   opts.theme = "gruvbox"
    -- end,
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = LazyVim.config.icons
      local colors = {
        bg = "#34343b",
        fg = "#7b7b7b",
        mbg = "#262537",
        yellow = "#ff6300",
        cyan = "#477bde",
        darkblue = "#081633",
        green = "#86dd7f",
        orange = "#ffb684",
        violet = "#c678dd",
        magenta = "#c678dd",
        blue = "#5f96ca",
        red = "#ffa3be",
        grey = "#3e3d50",
        lsp = "#97ff8f",
        diff_green = "#98be65",
        diff_orange = "#ff8800",
        diff_red = "#ec5f67",
      }

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        hide_lsp_diagnostics = function()
          return vim.o.columns > 140
        end,
        hide_diff = function()
          return vim.o.columns > 120
        end,
        hide_line_col = function()
          return vim.o.columns > 140
        end,
        hide_cwd = function()
          return vim.o.columns > 80
        end,
      }

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = "auto",
          component_separators = "",
          section_separators = { left = "", right = "" },
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard", "neo-tree" } },
        },
        sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {
            {
              "mode",
              icon = "",
              color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                  n = colors.blue,
                  i = colors.violet,
                  v = colors.cyan,
                  [""] = colors.cyan,
                  V = colors.cyan,
                  c = colors.magenta,
                  R = colors.orange,
                  no = colors.blue,
                  s = colors.orange,
                  S = colors.orange,
                  [""] = colors.orange,
                  ic = colors.yellow,
                  Rv = colors.orange,
                  cv = colors.blue,
                  ce = colors.blue,
                  r = colors.cyan,
                  rm = colors.cyan,
                  ["r?"] = colors.cyan,
                  ["!"] = colors.blue,
                  t = colors.green,
                }
                return { fg = mode_color[vim.fn.mode()], bg = colors.bg }
              end,
            },
            {
              "filetype",
              icon_only = true,
              colored = false,
              color = { fg = colors.fg },
              padding = { left = 1, right = 0 },
            },
            {
              "filename",
              cond = conditions.buffer_not_empty,
              color = { fg = colors.fg },
              padding = { left = 1, right = 1 },
            },
            {
              "branch",
              icon = "",
              color = { fg = colors.fg },
              padding = { left = 1, right = 1 },
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "󰅚 ", warn = " ", info = " ", hint = "󰛩 " },
              cond = conditions.hide_lsp_diagnostics,
              colored = true,
              always_visible = true,
            },
          },
          lualine_x = {
            {
              "diff",
              colored = true,
              symbols = { added = " ", modified = " ", removed = " " },
              diff_color = {
                added = { fg = colors.diff_green },
                modified = { fg = colors.diff_orange },
                removed = { fg = colors.diff_red },
              },
              cond = conditions.hide_diff,
            },
            -- {
            --   function()
            --     return "|"
            --   end,
            --   color = { fg = colors.diff_red },
            --   cond = conditions.hide_diff,
            -- },
            {
              function()
                return "Ln %l, Col %c"
              end,
              color = { fg = colors.fg },
              cond = conditions.hide_line_col,
              -- icon = "|",
            },
            {
              "o:encoding", -- option component same as &encoding in viml
              fmt = string.upper, -- I'm not sure why it's upper case either ;)
              cond = conditions.hide_in_width,
              color = { fg = colors.yellow, gui = "bold" },
            },
            {
              function()
                return "{} %Y"
              end,
              color = { fg = colors.blue, bg = colors.mbg, gui = "bold" },
              -- color = { fg = colors.blue, gui = "bold" },
            },
            {
              function()
                local msg = " "
                -- local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  if client.name == "GitHub Copilot" then
                    return ""
                  end
                end
                return msg
              end,
            },
            {
              function()
                local msg = "No Active Lsp"
                -- local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_clients()
                if next(clients) == nil then
                  return msg
                end
                for _, client in ipairs(clients) do
                  if client.name ~= "null-ls" and client.name ~= "GitHub Copilot" then
                    return (vim.o.columns > 100 and client.name) or "LSP"
                  end
                end
                return msg
              end,
              icon = "󰄭 ",
              color = { fg = colors.lsp, bg = colors.mbg },
              -- color = { fg = colors.lsp },
            },
          },
          lualine_y = {},
          lualine_z = {
            {
              function()
                local filepath = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                return "󰉖 " .. filepath
              end,
              color = { bg = colors.bg, fg = colors.red },
              cond = conditions.hide_cwd,
            },
          },
          -- lualine_a = { "mode" },
          -- lualine_b = { "branch" },
          --
          -- lualine_c = {
          --   LazyVim.lualine.root_dir(),
          --   {
          --     "diagnostics",
          --     symbols = {
          --       error = icons.diagnostics.Error,
          --       warn = icons.diagnostics.Warn,
          --       info = icons.diagnostics.Info,
          --       hint = icons.diagnostics.Hint,
          --     },
          --   },
          --   { "filetype",                   icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          --   { LazyVim.lualine.pretty_path() },
          -- },
          -- lualine_x = {
          --   -- stylua: ignore
          --   {
          --     function() return require("noice").api.status.command.get() end,
          --     cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --     color = function() return LazyVim.ui.fg("Statement") end,
          --   },
          --   -- stylua: ignore
          --   {
          --     function() return require("noice").api.status.mode.get() end,
          --     cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --     color = function() return LazyVim.ui.fg("Constant") end,
          --   },
          --   -- stylua: ignore
          --   {
          --     function() return "  " .. require("dap").status() end,
          --     cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
          --     color = function() return LazyVim.ui.fg("Debug") end,
          --   },
          --   -- stylua: ignore
          --   {
          --     require("lazy.status").updates,
          --     cond = require("lazy.status").has_updates,
          --     color = function() return LazyVim.ui.fg("Special") end,
          --   },
          --   {
          --     "diff",
          --     symbols = {
          --       added = icons.git.added,
          --       modified = icons.git.modified,
          --       removed = icons.git.removed,
          --     },
          --     source = function()
          --       local gitsigns = vim.b.gitsigns_status_dict
          --       if gitsigns then
          --         return {
          --           added = gitsigns.added,
          --           modified = gitsigns.changed,
          --           removed = gitsigns.removed,
          --         }
          --       end
          --     end,
          --   },
          -- },
          -- lualine_y = {
          --   { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
          --   { "location", padding = { left = 0, right = 1 } },
          -- },
          -- lualine_z = {
          --   function()
          --     return " " .. os.date("%R")
          --   end,
          -- },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {},
        },
        extensions = { "neo-tree", "lazy" },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      -- if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      --   local trouble = require("trouble")
      --   local symbols = trouble.statusline({
      --     mode = "symbols",
      --     groups = {},
      --     title = false,
      --     filter = { range = true },
      --     format = "{kind_icon}{symbol.name:Normal}",
      --     hl_group = "lualine_c_normal",
      --   })
      --   table.insert(opts.sections.lualine_c, {
      --     symbols and symbols.get,
      --     cond = function()
      --       return vim.b.trouble_lualine ~= false and symbols.has()
      --     end,
      --   })
      -- end

      return opts
    end,
  },
}
