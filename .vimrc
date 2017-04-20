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
set background=dark
colorscheme solarized

set backspace=2

" Unbind arrow keys (gotta use hjkl)
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Lightline status enabled all the time
set laststatus=2

" Lightline customization
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ }
      \ }

" Git Gutter
let g:gitgutter_sign_column_always = 1
