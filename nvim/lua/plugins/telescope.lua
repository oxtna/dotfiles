return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    keys = {
      { '<leader>ff', '<Cmd>Telescope find_files<CR>', desc = 'Telescope find' },
      { '<leader>fg', '<Cmd>Telescope live_grep<CR>', desc = 'Telescope grep' },
    },
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = '$ ',
          selection_caret = '-> ',
          entry_prefix = '• ',
          path_display = { 'smart' },
        }
      })
      pcall(require('telescope').load_extension, 'fzf')
    end,
  }
}

