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
vim.opt.listchars = { tab = '>·', trail = '·', nbsp = '·' }
vim.opt.shortmess = vim.opt.shortmess + 'sS'

-- Use Powershell on Windows
if vim.loop.os_uname().sysname == 'Windows_NT' then
  vim.opt.shell = vim.fn.executable('pwsh') and 'pwsh' or 'powershell'
  vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command \z
    [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
  vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  vim.opt.shellquote = ''
  vim.opt.shellxquote = ''
end

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
vim.keymap.set({ 'n', 'v' }, '/', '/\\v')

-- Stop highlighting search results
vim.keymap.set({ 'n', 'v' }, '<leader><space>', '<Cmd>noh<CR>')

-- Source and edit neovim's config file
vim.keymap.set('n', '<leader>sv', '<Cmd>source $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>ev', '<Cmd>vsplit $MYVIMRC<CR>')

-- Disable arrows in normal and visual modes
vim.keymap.set({ 'n', 'v' }, '<Left>', '')
vim.keymap.set({ 'n', 'v' }, '<Right>', '')
vim.keymap.set({ 'n', 'v' }, '<Up>', '')
vim.keymap.set({ 'n', 'v' }, '<Down>', '')

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Buffer navigation
vim.keymap.set('n', '<leader>z', '<Cmd>bp<CR>')
vim.keymap.set('n', '<leader>x', '<Cmd>bn<CR>')
vim.keymap.set('n', '<leader>c', '<Cmd>bd<CR>')

-- Packer
require('plugins')

-- LSP setup
require('mason').setup()

local lsps = { 'lua_ls' }

require('mason-lspconfig').setup({
  ensure_installed = lsps
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' }
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true)
      },
    }
  }
})

-- nvim-tree keymaps
vim.keymap.set('n', '<F6>', '<Cmd>NvimTreeRefresh<CR><Cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<F7>', '<Cmd>NvimTreeRefresh<CR><Cmd>NvimTreeFindFile<CR>')

-- Telescope settings and keymaps
local telescope = require('telescope')
telescope.setup({
  defaults = {
    prompt_prefix = '$ ',
    selection_caret = '-> ',
    entry_prefix = '• ',
    path_display = { 'smart' },
  }
})
telescope.load_extension('fzf')
vim.keymap.set('n', '<leader>ff', '<Cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', '<Cmd>Telescope live_grep<CR>')

-- Colorscheme configuration
require('nightfox').setup({
  groups = {
    terafox = {
      NonText = { fg = '#3be368' },
      Whitespace = { fg = '#3be368' },
    }
  }
})

vim.cmd('colorscheme terafox')

-- Better syntax highlighting
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'lua',
    'python',
    'ruby',
    'help',
    'markdown',
    'json',
    'c',
  },
  sync_install = false,
  auto_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})

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

-- Does not work during command input
local function current_time()
  return os.date('%X')
end

require('lualine').setup({
  options = {
    theme = theme,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      statusline = { 'NvimTree', 'packer' },
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

