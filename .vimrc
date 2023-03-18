" Sanity
set nocompatible

" Dark mode
set bg=dark

" Disable modeline settings at the top of the file
set nomodeline

" File encoding
set encoding=utf-8

" Syntax highlighting
syntax enable

" Show current command while typing
set showcmd

" Turn off mode info because it's in the statusline
set noshowmode

" Show next lines while scrolling
set scrolloff=4

" Show next columns while scrolling
set sidescrolloff=4

" Show line numbers
set number

" Show line numbers relative to the current line
set relativenumber

" Set current line number colors and style
hi CursorLineNr cterm=bold ctermfg=magenta ctermbg=black

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

" Show hidden characters
set list
set listchars=tab:\|·,trail:·,extends:>,precedes:<,nbsp:·

" Better line wrapping
set showbreak=¬\ 
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

" Vimscript indentation rules
autocmd FileType vim setlocal shiftwidth=2 tabstop=2

" Ruby indentation rules
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2

" JavaScript indentation rules
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2

let g:fullmodename = {
  \ 'n' : 'NORMAL',
  \ 'v' : 'VISUAL',
  \ 'V' : 'V-LINE',
  \ '' : 'V-BLOCK',
  \ 'i' : 'INSERT',
  \ 'R' : 'REPLACE',
  \ 'c' : 'COMMAND'
  \}

let g:modecolor = {
  \ 'n' : '%1*',
  \ 'v' : '%2*',
  \ 'V' : '%2*',
  \ '' : '%2*',
  \ 'i' : '%3*',
  \ 'R' : '%4*',
  \ 'c' : '%5*'
  \}

" Normal
hi User1 ctermbg=black ctermfg=white
" Visual
hi User2 ctermbg=black ctermfg=darkyellow
" Insert
hi User3 ctermbg=black ctermfg=blue
" Replace
hi User4 ctermbg=black ctermfg=magenta
" Command (Search)
hi User5 ctermbg=black ctermfg=green
" Filepath
hi User6 ctermbg=black ctermfg=white
" Search count
hi User7 ctermbg=black ctermfg=darkgreen
" Filetype
hi User8 ctermbg=black ctermfg=gray
" Filler
hi User9 ctermbg=black ctermfg=white

function! StatuslineMode()
  return g:modecolor[mode()] . ' ' . g:fullmodename[mode()] . ' %9*'
endfunction

function! StatuslineFilepath()
  let filepath = expand('%:t') !=# '' ? ( len(expand('%:p')) > 40 ? expand('%:t') : expand('%:p') ) : '[No Name]'
  return '%6* ' . filepath . ' %9*'
endfunction

function! StatuslineModified()
  return &modifiable ? ( &modified ? '%#error# + %9*' : '' ) : '%#error# / %9*'
endfunction

" TODO
function! StatuslineSearchCount()
  return '%7*%9*'
endfunction

function! StatuslineFiletype()
  return '%8*%y%9*'
endfunction

function! StatuslinePosition()
  return ' %l:%c  %P/%L '
endfunction

function! Statusline()
  return StatuslineMode() . ' ' . StatuslineFilepath() . ' ' . StatuslineModified() . '%=' . StatuslineSearchCount() . ' ' . StatuslineFiletype() . ' ' . StatuslinePosition()
endfunction

set statusline=%!Statusline()

" Plugins will be downloaded under `~/.vim/plugged`
call plug#begin()

Plug 'preservim/nerdtree'

" Plugins become visible to Vim after this call
call plug#end()

" Make NERDTree shortcuts
nmap <F6>   :NERDTreeToggle<CR>
nmap <F5>   :NERDTreeRefreshRoot<CR>

" NERDTree settings
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeDirArrowExpandable = '>'
let NERDTreeDirArrowCollapsible = 'v'
let NERDTreeIgnore = [ '\.swp$' ]
let NERDTreeWinSize = 30

