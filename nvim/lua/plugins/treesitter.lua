return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = 'nvim-lua/plenary.nvim',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'json',
        'c',
      },
      sync_install = false,
      auto_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    },
  }
}

