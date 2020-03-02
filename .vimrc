" bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
" Plug 'tmhedberg/SimpylFold'
" Plug 'vim-syntastic/syntastic'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'google/yapf'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-python'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

colorscheme afterglow
filetype plugin indent on
syntax on
set background=dark
set cursorline
set showmatch
set history=500
set ignorecase
set incsearch " hightlight match while typing
set encoding=utf-8
set hidden " don't warn when switching from unsaved buffer
set clipboard=unnamed " use system clipboard
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=119
set expandtab
set autoindent
set pastetoggle=<F2>
let python_highlight_all=1

inoremap jk <ESC>
let mapleader=","

" statusline
set laststatus=2
set statusline=
set statusline+=%f
set statusline+=\%m
set statusline+=\ %y
set statusline+=\ pos:\ %l,%c
" switch to the right side
set statusline+=%=
set statusline+=%{FugitiveStatusline()}
set statusline+=\ lines:\ %L
set statusline+=\ buffer:\ %n

" set default split locations
set splitbelow
set splitright

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" folding
set foldmethod=indent
set foldlevel=99
" fold with space
nnoremap <space> za

" YouCompleteMe options
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" NERDTree options
let NERDTreeIgnore=['\.pyc$', '\~$']

" pep8 indentation
au BufNewFile,BufRead *.py call SetPythonOptions()

" indentation for web development
au BufNewFile,BufRead *.js, *.html, *.css call SetWebDevOptions()

function! SetPythonOptions()
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=119
    set expandtab
    set autoindent
    set fileformat=unix
    let g:pymode_python='python3'
    let g:pymode_options_max_line_length=119
    let g:pymode_virtualenv=1
    let g:pymode_run=1
    let g:pymode_run_bind='<leader>r'
endfunction

function! SetWebDevOptions()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction

" autostart NERDTree if nothing was passed to vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <leader>space :NERDTreeToggle<CR>
let NERDTreeWinSize=24
