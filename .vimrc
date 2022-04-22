" Sanity
set nocompatible

" Set modeline
set modeline
set modelines=10

" File encoding
set encoding=utf-8

" Syntax highlighting
syntax enable

" Show current command while typing
set showcmd

" Enable the statusline
set ruler

" Turn off mode info because it's in the statusline
set noshowmode

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Always show status line at the bottom, even if you have only one window open
set laststatus=2

" Backspace over anything
set backspace=indent,eol,start

" Search is not case-sensitive if all characters in the string are lowercase
set ignorecase
set smartcase

" Enable searching as you type
set incsearch

" Highlight during searching
set hlsearch

" Set leader key
let mapleader=','

" Stop highlighting search
nnoremap <silent> <leader><space> :noh<CR>

" Unbind Ex mode
nmap Q <Nop>

" Disable audible bell
set noerrorbells visualbell t_vb=

" Mouse support
set mouse=a

" Show hidden characters
set list
set listchars=tab:▶-,trail:~,extends:>,precedes:<,nbsp:·

" Better line wrapping
set showbreak=\\¬
set breakindent

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

" Buffer navigation
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>c :bd<CR>

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

filetype plugin indent on

" Make tabs appear like 4 spaces
set tabstop=4

" Set indent size to 4 spaces
set shiftwidth=4

" Default settings, just to make sure
set softtabstop=0

" Insert 4 spaces on pressing tab
set expandtab

" Ruby indentation rules
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" JavaScript indentation rules
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

" Plugins will be downloaded under the specified directory
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'

" Plugins become visible to Vim after this call
call plug#end()

" Make NERDTree shortcuts
nmap <F6>   :NERDTreeToggle<CR>
nmap <F5>   :NERDTreeRefreshRoot<CR>

" NERDTree settings
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = [ '\.swp$' ]
let NERDTreeWinSize = 60

" vim-rainbow activation
let g:rainbow_active = 1

" solarized theme
set background=dark
let g:solarized_termtrans = 1
colorscheme solarized

" Lightline format
let g:lightline = {
    \ 'colorscheme': 'powerline',
    \ 'active': {
    \   'left': [
    \       [ 'mode', 'paste' ],
    \       [ 'readonly', 'filepath' ]
    \       ],
    \   'right': [
    \       [ 'lineinfo' ],
    \       [ 'percent' ],
    \       [ 'fileencoding' ],
    \       [ 'filetype' ]
    \       ]
    \   },
    \ 'component_function': {
    \   'filepath': 'LightlineFilepath'
    \   }
    \ }

function! LightlineFilepath()
    let filepath = expand('%:t') !=# '' ? ( len(expand('%:p')) > 50 ? expand('%:t') : expand('%:p') ) : '[No Name]'
    let modified = &modified ? ' +' : ''
    return filepath . modified
endfunction

