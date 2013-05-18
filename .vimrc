set nocompatible

" ## VUNDLE
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" ##

" Underline the current line with dashes
nnoremap <F5> yypVr-
inoremap <F5> <Esc>yypVr-o

set history=700
set foldmethod=marker

let mapleader=","

set scrolloff=2

set wildmenu

set ruler

set cmdheight=1

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set wildmode=longest,list

au FileType text setlocal spell
au FileType text setlocal wrap

set hlsearch
set incsearch
set ignorecase
set smartcase
set lazyredraw

set showmatch
set matchtime=2

set hidden

set cursorline

set splitbelow
set splitright

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set clipboard=unnamed

if has("unix") && v:version >= 703
	set clipboard+=unnamedplus
endif

syntax on
set bg=light
set t_Co=256
colorscheme Tomorrow

if has("gui_running")
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	colorscheme Tomorrow
endif

set encoding=utf-8

try
	lang en_US
catch
endtry

set fileformats=unix,dos,mac

set backupdir=$HOME/.vim/backup

set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

set autoindent
set smartindent
set nowrap
set linebreak
set number

set laststatus=2

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
	let curdir = substitute(getcwd(), "/home/pazuru/","~/","g")
	return curdir
endfunction

function! HasPaste()
	if &paste
		return 'PASTE MODE	'
	else
		return ''
	endif
	set ignorecase
	set smartcase
endfunction

map <leader>ss :setlocal spell!<cr>
set spelllang=en_ca
map <F2> :set list! list?<cr>

"Unbind arrow keys
for prefix in ['i','n','v']
	for key in ['<Up>', '<Down>', '<Left>', '<Right>']
		exe prefix . "noremap " . key . " <Nop>"
	endfor
endfor

"Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

filetype plugin indent on
