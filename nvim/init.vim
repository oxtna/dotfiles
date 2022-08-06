" Sanity
set nocompatible

" Enable mouse
set mouse=a

" Set modeline
set modeline
set modelines=10

" Cursor blinking in insert mode
set guicursor=n-v-c-sm:block-blinkwait4000-blinkon1000-blinkoff1000
            \,i-ci-ve:ver25-blinkwait1000-blinkon600-blinkoff600
            \,r-cr-o:hor20-blinkwait1000-blinkon600-blinkoff600

" Line numbers
set number
set relativenumber

" Show next lines while scrolling
set scrolloff=4

" Show next columns while scrolling
set sidescrolloff=4

" Tab settings
set autoindent
set softtabstop=0
set expandtab
set tabstop=4
set shiftwidth=4

" Set leader key
let mapleader=','

" Source neovim's config file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Edit neovim's config file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Grep operator
" Thanks Steve Losh
nnoremap <leader>g :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type) abort
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

" Surround mappings
nnoremap <leader>" viW<esc>a"<esc>Bi"<esc>E
nnoremap <leader>' viW<esc>a'<esc>Bi'<esc>E
nnoremap <leader>` viW<esc>a`<esc>Bi`<esc>E
nnoremap <leader>( viW<esc>a)<esc>Bi(<esc>E
nnoremap <leader>[ viW<esc>a]<esc>Bi[<esc>E
vnoremap <leader>" <esc>`<i"<esc>`>a"<esc>
vnoremap <leader>' <esc>`<i'<esc>`>a'<esc>
vnoremap <leader>` <esc>`<i`<esc>`>a`<esc>
vnoremap <leader>( <esc>`<i(<esc>`>a)<esc>
vnoremap <leader>[ <esc>`<i[<esc>`>a]<esc>

augroup filetypes
    " Ruby indentation rules
    autocmd FileType ruby setlocal shiftwidth

    " JavaScript indentation rules
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup END

" Other sane defaults
set cursorline
set encoding=utf-8
set showcmd
set noshowmode
set backspace=indent,eol,start
set noerrorbells visualbell t_vb=
filetype plugin indent on
nnoremap / /\v

" Show invisible characters
set list
set listchars=tab:\|·,trail:·,extends:>,precedes:<,nbsp:·

" Better line wrapping
set showbreak=\ ¬
set breakindent

" Status bar
set ruler
set laststatus=2

" Search settings
set ignorecase
set smartcase
set incsearch
set hlsearch
set wildmenu

" Window split settings
set splitbelow
set splitright

" Stop highlighting search
nnoremap <silent> <leader><space> :noh<CR>

" Buffer navigation
noremap <silent> <leader>z :bp<CR>
noremap <silent> <leader>x :bn<CR>
noremap <silent> <leader>c :bd<CR>

" Window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" QoL
cnoreabbrev W!    w!
cnoreabbrev Q!    q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq    wq
cnoreabbrev Wa    wa
cnoreabbrev wQ    wq
cnoreabbrev WQ    wq
cnoreabbrev W     w
cnoreabbrev Q     q
cnoreabbrev Qall  qall

" Disable arrows in normal mode
nnoremap <Left>     <Nop>
nnoremap <Right>    <Nop>
nnoremap <Up>       <Nop>
nnoremap <Down>     <Nop>

" Disable arrows in visual mode
vnoremap <Left>     <Nop>
vnoremap <Right>    <Nop>
vnoremap <Up>       <Nop>
vnoremap <Down>     <Nop>

" Disable Ex mode
nmap Q <Nop>

" Required by plugins
set termguicolors

" Packer plugins
lua require('plugins')

" nvim-tree settings
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_symlink_arrow = ' -> '
let g:nvim_tree_icon_padding = '  '
let g:nvim_tree_special_files = { 'README.md': 1 }

" nvim-tree shortcuts
noremap <F5> :NvimTreeRefresh<CR>
noremap <F6> :NvimTreeToggle<CR>
noremap <F7> :NvimTreeFindFile<CR>

lua << END
-- Colorscheme setup
local groups = {
  NonText = { fg = "#3be368" },
  Whitespace = { fg = "#3be368" },
}

require("nightfox").setup({ groups = groups })

vim.cmd("colorscheme terafox")

-- Initialize status bar
-- Thanks `shadmansaleh`
local colors = {
  red = '#ca1243',
  grey = '#616266',
  black = '#383a42',
  white = '#f3f3f3',
  violet = '#660965',
  pink = '#d4649f',
  orange = '#fe8019',
  green = '#8ec07c',
  blue = '#5cc6db',
}

local theme = {
  normal = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.white },
    z = { fg = colors.white, bg = colors.black },
  },
  insert = { a = { fg = colors.white, bg = colors.violet } },
  visual = { a = { fg = colors.black, bg = colors.orange } },
  replace = { a = { fg = colors.black, bg = colors.pink } },
  command = { a = { fg = colors.black, bg = colors.blue } },
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
      table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
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
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '/'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
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
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
END
