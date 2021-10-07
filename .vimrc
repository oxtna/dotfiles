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

" Unbind Ex mode
nmap Q <Nop>

" Disable audible bell
set noerrorbells visualbell t_vb=

" Mouse support
" set mouse+=a
" set mouse=a

" Disable arrows in normal mode
nnoremap <Left>		<Nop>
nnoremap <Right>	<Nop>
nnoremap <Up>		<Nop>
nnoremap <Down>		<Nop>

" Disable arrows in insert mode
inoremap <Left>		<Nop>
inoremap <Right>	<Nop>
inoremap <Up>		<Nop>
inoremap <Down>		<Nop>

filetype plugin indent on

" Make tabs appear like 4 spaces
set tabstop=4

" Set indent size to 4 spaces
set shiftwidth=4

" Default settings, just to make sure
set softtabstop=0

" Insert 4 spaces on pressing tab
set expandtab

" Plugins will be downloaded under the specified directory
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'frazrepo/vim-rainbow'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'valloric/youcompleteme'
Plug 'altercation/vim-colors-solarized'

" Plugins become visible to Vim after this call
call plug#end()

" Make NERDTree shortcuts
nmap <F6>	:NERDTreeToggle<CR>
nmap <F7>	:NERDTreeRefreshRoot<CR>

" NERDTree settings
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = [ '\.swp$' ]

" YouCompleteMe settings
let g:ycm_auto_trigger = 1

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
	\	'left': [
	\		[ 'mode', 'paste' ],
	\		[ 'readonly', 'filepath' ]
	\		],
	\	'right': [
	\		[ 'lineinfo' ],
	\		[ 'percent' ],
	\		[ 'fileencoding' ],
	\		[ 'filetype' ]
	\		]
	\ 	},
	\ 'component_function': {
	\	'filepath': 'LightlineFilepath'
	\	}
	\ }

function! LightlineFilepath()
	let filepath = expand('%:t') !=# '' ? ( len(expand('%:p')) > 50 ? expand('%:t') : expand('%:p') ) : '[No Name]'
	let modified = &modified ? ' +' : ''
	return filepath . modified
endfunction
