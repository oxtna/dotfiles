return {
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    config = function()
      local theme = {
        fill = 'TabLineFill',
        head = 'TabLine',
        current_tab = 'TabLineSel',
        tab = 'TabLine',
        win = 'TabLine',
        tail = 'TabLine',
      }
      require('tabby.tabline').set(function(line)
        return {
          {
            { ' 󰣎 󰣏 󰣑 󰣐 ', hl = theme.head },
          },
          line.tabs().foreach(function(tab)
            local sep_color = tab.is_current() and theme.current_tab or theme.tab
            local suits_filled = { '󰣎 ', '󰣏 ', '󰣑 ', '󰣐 ' }
            local suits_outline = { '󱢟 ', '󱀝 ', '󱢲 ', '󱢠 ' }
            local suit_index = tab.number() % 4 == 0 and 4 or tab.number() % 4
            return {
              line.sep(' ', sep_color, theme.fill),
              tab.is_current() and suits_filled[suit_index] or suits_outline[suit_index],
              tab.number(),
              tab.name(),
              hl = theme.fill,
              margin = ' ',
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            local sep_color = win.is_current() and theme.current_tab or theme.win
            return {
              line.sep('  ', sep_color, theme.fill),
              win.is_current() and '󰘸 ' or '󰘹 ',
              win.buf_name(),
              hl = theme.fill,
              margin = ' ',
            }
          end),
          {
            { '     ', hl = theme.tail },
          },
          hl = theme.fill,
        }
      end)
    end,
  }
}

