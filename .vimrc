" tabs / spaces
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
filetype plugin indent on

" Searching
set incsearch
set hlsearch

" UI
syntax enable
set number
set wildmenu
set showmatch

" CtrlP.vim
" set runtimepath^=~/.vim/bundle/ctrlp.vim

" Pathogen
execute pathogen#infect()

" Clipboard
set clipboard="unnamedplus"

" Colors
colorscheme solarized

set backspace=2

" Unbind arrow keys (gotta use hjkl)
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>
