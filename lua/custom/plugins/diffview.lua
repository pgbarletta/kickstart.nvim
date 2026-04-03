return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen dev<cr>', desc = 'Diff vs dev' },
    { '<leader>gD', '<cmd>DiffviewOpen dev...HEAD<cr>', desc = 'Branch diff' },
    { '<leader>gs', '<cmd>DiffviewOpen --staged<cr>', desc = 'Staged diff' },
    { '<leader>gw', '<cmd>DiffviewOpen HEAD<cr>', desc = 'Workdir vs HEAD' },
  },
  opts = {},
}
