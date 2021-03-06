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
Plug 'yegappan/grep'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Markdown settings
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_emphasis_multiline = 0
"let g:vim_markdown_conceal_code_blocks = 0
autocmd FileType markdown set conceallevel=2
set conceallevel=0

" Leader functions
let mapleader=","
command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
nmap <Leader>o :Silent open %:h<cr>
nmap <leader>vimrc :tabe ~/.vimrc<cr>
nmap <Leader>r :source ~/.vimrc<cr>
" Paste on newline
nmap <Leader>p $p 
" Copy filename to buffer
nmap <Leader>yp :let @" = expand('%:p')<cr>
nmap <Leader>md :call PasteMDLink()<cr>
nmap <Leader>hp :call PreviewHugoPage(expand('%:p'))<cr>

function! GetURLTitle(url)
    " Bail early if the url obviously isn't a URL.
    if a:url !~ '^https\?://'
        return ""
    endif
    
    let title = system("python3 -c \"import bs4, requests; print(bs4.BeautifulSoup(requests.get('" . a:url . "').content, 'lxml').title.text.strip())\"")

    " Echo the error if getting title failed.
    if v:shell_error != 0
        echom title
        return ""
    endif

    " Strip trailing newline
    return substitute(title, '\n', '', 'g')
endfunction

function PasteMDLink()
    let url = getreg("+")
    let title = GetURLTitle(url)
    let mdLink = printf("[%s](%s)", title, url)
    execute "normal! a" . mdLink . "\<Esc>"
endfunction

let g:hugo_site_config = [ 'config.toml', 'config.yaml', 'config.json' ]
" The local Hugo server URL
let g:hugo_base_url = "http://localhost:1313/"

function! HugoBaseDirectory(filepath)
    let l:mods = ':p:h'
    let l:dirname = 'dummy'
    while !empty(l:dirname)
        let l:path = fnamemodify(a:filepath, l:mods)
        let l:mods .= ':h'
        let l:dirname = fnamemodify(l:path, ':t')
        " Check if the parent of the content directory contains a config file.
        let l:parent = fnamemodify(l:path, ":h")
        if HugoConfigFile(l:parent) != ""
            return l:parent
        endif
    endwhile

    return ""
endfunction

function! HugoConfigFile(dir)
    " :p adds the final path separator if a:dir is a directory.
    let l:dirpath = fnamemodify(a:dir, ':p')
    for config in g:hugo_site_config
        let l:file = l:dirpath . config
        if filereadable(l:file)
            return l:file
        endif
    endfor
    return ""
endfunction

function! PreviewHugoPage(filepath)
    let l:fullpath = fnamemodify(a:filepath, ':p')
    let l:basedir = HugoBaseDirectory(l:fullpath)
    if l:basedir == ""
        return ""
    endif
    let l:configpath = HugoConfigFile(l:fullpath)
    let l:contentpath = substitute(l:fullpath, l:basedir . '/', '', '')
    let l:url = systemlist("cd " . l:basedir . " && HUGO_BASEURL='" . g:hugo_base_url . "' hugo list all | grep " . l:contentpath . " | head -n 1 | cut -d ',' -f 8")[0]
    exe system("open " . l:url)
endfunction

nmap <Leader>hp :call PreviewHugoPage(expand('%'))<cr>

" -------------------------------------------------------------------------------------------------
" coc.nvim default settings
" -------------------------------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use U to show documentation in preview window
nnoremap <silent> U :call <SID>show_documentation()<CR>

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Disable Coc suggestions in markdown
autocmd FileType markdown let b:coc_suggest_disable = 1

