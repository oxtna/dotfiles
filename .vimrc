" Syntax highlighting
syntax on

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

" Make tabs appear like 4 spaces
set tabstop=4

" Set indent size to 4 spaces
set shiftwidth=4

" Default settings, just to make sure
set softtabstop=0 noexpandtab

" Make NERDTree shortcuts
nmap <F6>	:NERDTreeToggle<CR>
nmap <F7>	:NERDTreeRefreshRoot<CR>

" NERDTree settings
let NERDTreeShowHidden = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore = [ '\.swp$' ]

" ALE settings
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_set_signs = 1
let g:ale_echo_cursor = 1
let g:ale_set_balloons = 1
let g:ale_linters = { 'c': [ 'gcc', 'clang', 'clangcheck' ] }

" Lightline format
let g:lightline = {
	\ 'colorscheme': 'PaperColor',
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
