-- Sane defaults
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4
vim.opt.list = true
vim.opt.listchars = 'tab:>·,trail:·,nbsp:·'
vim.opt.shortmess = vim.opt.shortmess + 'sS'

-- Better line wrapping
vim.opt.showbreak = ' ¬'
vim.opt.breakindent = true
vim.opt.linebreak = true

-- Cursor blinking
vim.opt.guicursor = '\z
  n-v-c-sm:block-blinkwait4000-blinkon1000-blinkoff1000,\z
  i-ci-ve:ver25-blinkwait1000-blinkon600-blinkoff600,\z
  r-cr-o:hor20-blinkwait1000-blinkon600-blinkoff600,\z
'

-- Tab indentation settings
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Required by colorscheme
vim.opt.termguicolors = true

-- Quality of life
vim.cmd('cnoreabbrev W w')
vim.cmd('cnoreabbrev Q q')
vim.cmd('cnoreabbrev W! w!')
vim.cmd('cnoreabbrev Q! q!')
vim.cmd('cnoreabbrev Wq wq')
vim.cmd('cnoreabbrev WQ wq')
vim.cmd('cnoreabbrev Wa wa')
vim.cmd('cnoreabbrev WA wa')

local ft_augroup = vim.api.nvim_create_augroup('ft', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ruby', 'javascript', 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2',
  group = ft_augroup
})

vim.g.mapleader = ','

-- Always use 'very magic' searching
vim.api.nvim_set_keymap('n', '/', '/\\v', { noremap = true })

-- Stop highlighting search results
vim.api.nvim_set_keymap('n', '<leader><space>', ':noh<CR>',
  { noremap = true, silent = true })

-- Source and edit neovim's config file
vim.api.nvim_set_keymap('n', '<leader>sv', ':source $MYVIMRC<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ev', ':vsplit $MYVIMRC<CR>',
  { noremap = true, silent = true })

-- Disable arrows in normal and visual modes
vim.api.nvim_set_keymap('n', '<Left>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<Up>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<Left>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<Right>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<Up>', '', { noremap = true })
vim.api.nvim_set_keymap('v', '<Down>', '', { noremap = true })

-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l',
  { noremap = true, silent = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<leader>z', ':bp<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bn<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>c', ':bd<CR>',
  { noremap = true, silent = true })

-- Surround keymaps
-- TODO: Fix `WORD,` behavior
vim.api.nvim_set_keymap('n', '<leader>"', 'Ea"<esc>Bi"<esc>E',
  { noremap = true })
vim.api.nvim_set_keymap('n', "<leader>'", "Ea'<esc>Bi'<esc>E",
  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>(', 'Ea)<esc>Bi(<esc>E',
  { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>[', 'Ea]<esc>Bi[<esc>E',
  { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>"', '<esc>`<i"<esc>`>la"<esc>',
  { noremap = true })
vim.api.nvim_set_keymap('v', "<leader>'", "<esc>`<i'<esc>`>la'<esc>",
  { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>(', '<esc>`<i(<esc>`>la)<esc>',
  { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>[', '<esc>`<i[<esc>`>la]<esc>',
  { noremap = true })

-- TODO: Convert this to Lua
-- Grep operator
-- Thanks, Steve Losh
vim.api.nvim_exec([[
function! GrepOperator(type) abort
  let unnamed_register = @@

  try
    if a:type ==# 'v'
      normal! `<v`>y
    elseif a:type ==# 'char'
      normal! `[y`]
    endif

    silent execute "grep! -R " .. shellescape(@@) .. " ."
    copen
  finally
    let @@ = unnamed_register
  endtry
endfunction
]], false)
vim.api.nvim_set_keymap('n', '<leader>g', ':set operatorfunc=GrepOperator<CR>g@',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>g', ':<C-u>call GrepOperator(visualmode())<CR>',
  { noremap = true, silent = true })

-- Packer
require('plugins')

-- Colorscheme configuration
require('nightfox').override.groups({
  terafox = {
    NonText = { fg = '#3be368' },
    Whitespace = { fg = '#3be368' },
  }
})

vim.cmd('colorscheme terafox')

-- nvim-tree keymaps
vim.api.nvim_set_keymap('n', '<F6>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F7>', ':NvimTreeRefresh<CR>:NvimTreeFindFile<CR>',
  { noremap = true, silent = true })

-- Initialize status bar
-- Thanks, `shadmansaleh`
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
  end
  return ''
end

-- Does not work during command input
local function current_time()
  return os.date('%X')
end

local function process_filename(filename)
  
end

require('lualine').setup({
  options = {
    theme = theme,
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
      { 'filename', file_status = false, path = 1 },
      { modified, color = { bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
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
      { modified, color = { bg = colors.red } },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'filetype' },
    lualine_z = { '%l:%c', '%p%%/%L' },
  }),
})

