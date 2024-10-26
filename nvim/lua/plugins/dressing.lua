return {
  {
    'stevearc/dressing.nvim',
    event = 'VeryLazy',
    opts = {
      input = {
        relative = 'win',
        border = { '󰣐', ' ', '·', '·', '󰣏', ' ', '·', '·' },
        win_options = { winhighlight = 'FloatBorder:DressingBorder,FloatTitle:DressingTitle' },
      },
      select = {
        relative = 'win',
        border = { '󰣐', ' ', '·', '·', '󰣏', ' ', '·', '·' },
        win_options = { winhighlight = 'FloatBorder:DressingBorder,FloatTitle:DressingTitle' },
      },
    },
  }
}

