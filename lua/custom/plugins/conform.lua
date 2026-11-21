return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style.
      local disable_filetypes = {}
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can run multiple formatters sequentially
      python = { 'ruff_fix', 'ruff_format' },
      -- C/C++/CUDA (.cu and .cuh map to the `cuda` filetype)
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      cuda = { 'clang-format' },
      -- You can use a sub-list to tell conform to run *until* a formatter is found.
      javascript = { { 'prettierd', 'prettier' } },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      rst = {},
      ['_'] = { 'trim_whitespace' },
    },
    formatters = {
      ruff_fix = { args = { '--fix', '--line-length=100', '--exit-zero', '--no-cache', '-' } },
      ruff_format = { args = { 'format', '--line-length=100', '--no-cache', '-' } },
      -- Ubuntu's llvm packages only ship versioned binaries, and mason's
      -- clang-format package (a pip install) can't build a venv here.
      ['clang-format'] = {
        command = (function()
          for _, exe in ipairs { 'clang-format', 'clang-format-20', 'clang-format-18' } do
            if vim.fn.executable(exe) == 1 then
              return exe
            end
          end
          return 'clang-format'
        end)(),
      },
    },
  },
}