return {
  {
    'oxtna/vshow.nvim',
    event = 'VimEnter',
    config = function()
      require('vshow').setup({
        {
          nbsp = '+',
          space = '•',
          tab = '|•',
        },
        line = {
          eol = '$',
        },
      })
    end,
  }
}

