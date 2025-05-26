-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.api.nvim_create_user_command("RunCpp", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local file_path = vim.api.nvim_buf_get_name(bufnr)
      local file_dir = vim.fn.fnamemodify(file_path, ":h")
      local output_dir = file_dir .. "/output"
      local file_name = vim.fn.fnamemodify(file_path, ":t")
      local file_name_without_ext = vim.fn.fnamemodify(file_path, ":t:r")
      -- local file_extension = vim.fn.fnamemodify(file_path, ":e")
      -- local coderun_dir = file_dir
      if vim.fn.isdirectory(output_dir) == 0 then
        vim.fn.mkdir(output_dir)
      end
      local cmd = "'cd "
        .. file_dir
        .. " &&"
        .. " clang++ "
        .. file_name
        .. " -o "
        .. output_dir
        .. "/"
        .. file_name_without_ext
        .. " && "
        .. output_dir
        .. "/"
        .. file_name_without_ext
        .. "'"
      vim.cmd("TermExec direction=vertical size=40 cmd=" .. cmd)
    end, { desc = "Run Cpp file" })
  end,
})
