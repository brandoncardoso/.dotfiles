set nocompatible
filetype off

" ## VUNDLE
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'godlygeek/tabular'
Plugin 'itchyny/lightline.vim'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'morhetz/gruvbox'
call vundle#end()
" ##

filetype plugin indent on

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

let mapleader=","

" Underline the current line with dashes
nnoremap <F5> yypVr-
inoremap <F5> <Esc>yypVr-o

set history=700
set foldmethod=marker

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
set bg=dark
set t_Co=256
colorscheme gruvbox

if has("gui_running")
	set guioptions-=m
	set guioptions-=T
	set guioptions-=r
	colorscheme gruvbox
endif

" set transparent background
hi Normal guibg=NONE ctermbg=NONE

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
	let curdir = substitute(getcwd(),"$HOME","~/","g")
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

nnoremap <leader>n :noh<cr>

"Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

