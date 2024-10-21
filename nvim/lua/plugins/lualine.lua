return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
      local colors = {
        black = '#383a42',
        white = '#f3f3f3',
        dark_teal = '#152528',
        grey = '#616266',
        pink = '#d4649f',
        red = '#ca1243',
        orange = '#fe8019',
        green = '#8ec07c',
        blue = '#5cc6db',
        violet = '#660965',
      }

      local theme = {
        normal = {
          a = { fg = colors.white, bg = colors.dark_teal },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.white, bg = colors.dark_teal },
          x = { fg = colors.white, bg = colors.dark_teal },
          z = { fg = colors.white, bg = colors.black },
        },
        insert = {
          a = { fg = colors.black, bg = colors.blue },
          z = { fg = colors.black, bg = colors.blue },
        },
        visual = {
          a = { fg = colors.black, bg = colors.orange },
          z = { fg = colors.black, bg = colors.orange },
        },
        replace = {
          a = { fg = colors.white, bg = colors.violet },
          z = { fg = colors.white, bg = colors.violet },
        },
        command = {
          a = { fg = colors.black, bg = colors.green },
          z = { fg = colors.black, bg = colors.green },
        },
      }

      local empty = require('lualine.component'):extend()
      function empty:draw(default_highlight)
        self.status = ''
        self.applied_separator = ''
        self:apply_highlights(default_highlight)
        self:apply_section_separators()
        return self.status
      end

      -- Put proper separators and gaps between components in sections
      local function process_sections(sections)
        for name, section in pairs(sections) do
          local left = name:sub(9, 10) < 'x'
          for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
            table.insert(section, pos * 2, {
              empty, color = { fg = colors.dark_teal, bg = colors.dark_teal }
            })
          end
          for id, comp in ipairs(section) do
            if type(comp) ~= 'table' then
              comp = { comp }
              section[id] = comp
            end
            comp.separator = left and { right = '' } or { left = '' }
          end
        end
        return sections
      end

      -- Make a nice search result string
      -- ` ABC [X/Y]`
      local function search_result()
        if vim.v.hlsearch == 0 then
          return ''
        end
        local last_search = vim.fn.getreg('/')
        if not last_search or last_search == '' then
          return ''
        end
        local searchcount = vim.fn.searchcount { maxcount = 9999 }
        -- Skip the `very magic` characters
        if last_search:sub(1, 2) == '\\v' then
          last_search = last_search:sub(3, #last_search)
        end
        return ' ' .. last_search .. ' [' .. searchcount.current .. '/' .. searchcount.total .. ']'
      end

      local function modified()
        if vim.bo.modified then
          return '+'
        elseif vim.bo.modifiable == false or vim.bo.readonly == true then
          return '/'
        else
          return ''
        end
      end

      require('lualine').setup({
        options = {
          theme = 'tokyonight',
          component_separators = '',
          section_separators = '',
          disabled_filetypes = {
            statusline = { 'NvimTree' },
          },
        },
        sections = process_sections({
          lualine_a = {
            'mode',
          },
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              source = { 'nvim' },
              sections = { 'error' },
              diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
            },
            {
              'diagnostics',
              source = { 'nvim' },
              sections = { 'warn' },
              diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
            },
            { 'filename', file_status = false,                           path = 1 },
            { modified,   color = { bg = colors.red, fg = colors.white } },
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { search_result, 'filetype' },
          lualine_z = { '%l:%c', '%p%%/%L' },
        }),
        inactive_sections = process_sections({
          lualine_a = {},
          lualine_b = {
            'branch',
            'diff',
            { 'filename', file_status = false, path = 1 },
            modified,
          },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { 'filetype' },
          lualine_z = { '%l:%c', '%p%%/%L' },
        }),
      })
    end,
  }
}

