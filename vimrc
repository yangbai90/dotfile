set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=~/.vim/bundle/LanguageClient-neovim
set runtimepath+=~/.vim-plugins/LanguageClient-neovim
call vundle#begin()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" start to install different plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For Surroundings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'tpope/vim-surround'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For NERDTREE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/nerdtree'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'scrooloose/syntastic'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For Vim-Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For autopair
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'jiangmiao/auto-pairs'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For Fortran
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'rudrab/vimf90' 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'valloric/youcompleteme'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" For Language server
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" (Optional) Multi-entry selection UI.
Plugin 'junegunn/fzf'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" settings for Fortran
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let fortran_free_source=1
let fortran_do_enddo=1
" Turn on line numbers and
" row/column numbers
set nu
set ruler

" Make vim echo commands as they
" are being entered.
set showcmd

" Set tabstops to two spaces
" and ensure tab characters are
" expanded into spaces.
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2

" Fix backspace key
set bs=2

" Set up searching so
" that it jumps to matches
" as the word is being
" entered and is case-insensitive
set incsearch
set ignorecase
set smartcase
""""""""""""""""""""
"""""" for vimf90
let fortran_leader = "your chosen key"
let fortran_linter=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" settings for NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree and leave the cursor in it.
autocmd VimEnter * NERDTree
" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" settings for Vim Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
""" Separators can be configured independently for the tabline
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" settings for fprettify
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd Filetype fortran setlocal formatprg=fprettify\ --silent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""" settings for Language server
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
    \ 'fortran': ['fortls', '--symbol_skip_mem', '--incrmental_sync', '--autocomplete_no_prefix'],
    \ }

" note that if you are using Plug mapping you should not use `noremap` mappings.
nmap <F5> <Plug>(lcn-menu)
" Or map each action separately
nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)
