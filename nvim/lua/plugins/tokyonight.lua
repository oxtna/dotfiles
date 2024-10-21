return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        style = 'night',
        styles = {
          sidebars = 'dark',
          floats = 'dark',
        },
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  }
}

