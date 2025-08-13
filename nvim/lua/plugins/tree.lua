return {
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    keys = {
      { '<F6>', '<Cmd>NvimTreeRefresh<CR><Cmd>NvimTreeToggle<CR>', desc = 'NvimTree' },
      { '<F7>', '<Cmd>NvimTreeRefresh<CR><Cmd>NvimTreeFindFile<CR>', desc = 'NvimTree' },
    },
    config = function()
      require('nvim-tree').setup({
        view = { adaptive_size = true },
        renderer = {
          add_trailing = true,
          highlight_opened_files = 'icon',
          icons = {
            padding = '  ',
            symlink_arrow = ' -> ',
          },
          special_files = {
            'README.md',
            'readme.md',
          },
        },
      })
    end,
  }
}

