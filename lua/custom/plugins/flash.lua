-- Flash.nvim plugin for quick navigation
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  ---@type Flash.Config
  opts = {
    -- labels = "asdfghjklqwertyuiopzxcvbnm",
    labels = 'asdfghjkl;',
    char = {
      jump_labels = true,
    },
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = true,
        keys = { 'f', 'F', 't', 'T' },
        autohide = true,
        highlight = { backdrop = false },
      },
    },
    anim = {
      enable = false,
      duration = 0,
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
}

