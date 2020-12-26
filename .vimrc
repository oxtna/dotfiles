" Syntax highlighting
syntax on

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

" Disable arrows in normal mode
nnoremap <Left>		:echoe "Use H"<CR>
nnoremap <Right>	:echoe "Use L"<CR>
nnoremap <Up>		:echoe "Use K"<CR>
nnoremap <Down>		:echoe "Use J"<CR>

" Disable arrows in insert mode
inoremap <Left>		<ESC>:echoe "Use H"<CR>
inoremap <Right>	<ESC>:echoe "Use L"<CR>
inoremap <Up>		<ESC>:echoe "Use K"<CR>
inoremap <Down>		<ESC>:echoe "Use J"<CR>

" Make tabs appear like 4 spaces
set tabstop=4

" Set indent size to 4 spaces
set shiftwidth=4

" Default settings, just to make sure
set softtabstop=0 noexpandtab
