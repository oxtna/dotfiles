-- Sane defaults
vim.opt.showmode = false
vim.opt.showtabline = 2
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

-- Disabled, while I figure out to make this less annoying for special characters
--[[
-- Always use 'very magic' searching
vim.keymap.set({ 'n', 'v' }, '/', '/\\v')
--]]
vim.g.mapleader = ','

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

-- Tab navigation
vim.keymap.set({ 'n', 'v' }, 'gt', '')
vim.keymap.set({ 'n', 'v' }, 'gT', '')
vim.keymap.set('n', '<leader>tn', '<Cmd>tabnew<CR>', { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>tz', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tx', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tc', '<Cmd>tabclose<CR>', { desc = 'Close tab' })

-- File formatting
local function clang_format_buffer()
  if vim.bo.readonly then
    return
  end
  local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
  local result = vim.fn.system('clang-format', content)
  if vim.v.shell_error ~= 0 then
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(result, '\n', { plain = true }))
end

vim.api.nvim_create_augroup('MyFileType', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'MyFileType',
  pattern = 'lua',
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  group = 'MyFileType',
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.keymap.set('n', '<leader>d', clang_format_buffer, { desc = 'Format buffer' })
  end,
})

-- Custom highlight colors
vim.api.nvim_set_hl(0, 'NonText', { fg = '#8917e6' })
vim.api.nvim_set_hl(0, 'Whitespace', { fg = '#469494' })
vim.api.nvim_set_hl(0, 'DressingBorder', { fg = '#cc0036', bg = '#16161e' })
vim.api.nvim_set_hl(0, 'DressingTitle', { fg = '#2b92e0', bg = '#16161e' })

-- Plugins
require('config.lazy')
vim.keymap.set('n', '<leader>l', '<Cmd>Lazy<CR>')

