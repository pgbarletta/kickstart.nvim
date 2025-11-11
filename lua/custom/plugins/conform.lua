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
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can run multiple formatters sequentially
      python = { 'ruff_fix', 'ruff_format' },
      -- You can use a sub-list to tell conform to run *until* a formatter is found.
      javascript = { { 'prettierd', 'prettier' } },
      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
  },
}