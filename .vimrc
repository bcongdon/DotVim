" Basic settings
set mouse=a
set number relativenumber
set encoding=utf_8
set nocompatible

" tabs / spaces
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
filetype plugin indent on

" automatically re-read
set autoread

" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" UI
syntax enable
set number
set wildmenu
set showmatch
set background=dark
set t_Co=256

" Splitting
set splitbelow splitright

" Pathogen
execute pathogen#infect()

" Clipboard
set clipboard="unnamedplus"

" Colors
set background=dark
colorscheme solarized

set backspace=2

" Lightline status enabled all the time
set laststatus=2

" Center screen when entering Insert mode
autocmd InsertEnter * norm zz

" Enable spellcheck on text files
autocmd FileType markdown setlocal spell spelllang=en_us

" Lightline customization
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ }
      \ }

" Git Gutter
let g:gitgutter_sign_column_always = 1

" don't use arrowkeys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>
inoremap <Left>  <NOP>
inoremap <Right> <NOP>

" Paste on newline
nmap ,p $p 

" Ctrl-P to enter fzf
map <C-P> :Files<Enter>

" Prettier
let g:prettier#quickfix_enabled = 0
autocmd BufWritePost *.md Prettier

" VimPlug Plugins
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

call plug#end()

" Markdown settings
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_emphasis_multiline = 0
"let g:vim_markdown_conceal_code_blocks = 0
set conceallevel=2

" Leader functions
let mapleader=","
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
map <Leader>o :Silent open %:h<cr>
map <leader>vimrc :tabe ~/.vim/.vimrc<cr>
map <Leader>r :source ~/.vimrc<cr>
