" bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'tmhedberg/SimpylFold'
Plug 'airblade/vim-gitgutter'
" Plug 'vim-syntastic/syntastic'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'google/yapf'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()

" fzf settings
set rtp+=~/.fzf

colorscheme afterglow
" colorscheme atom
" colorscheme nord
" colorscheme wombat256mod
filetype plugin indent on
syntax on
set background=dark
set cursorline
set showmatch
set history=500
" search settings
set ignorecase
set smartcase
set incsearch " hightlight match while typing
set hlsearch
nmap <silent> <BS> :nohlsearch<CR>
set encoding=utf-8
set hidden " don't warn when switching from unsaved buffer
set clipboard^=unnamed " use system clipboard
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=119
set expandtab
set autoindent
set backspace=indent,eol,start "allow backspace to delete as expected
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
set statusline+=\ %{kite#statusline()}
" switch to the right side
set statusline+=%=
set statusline+=%{FugitiveStatusline()}
set statusline+=\ lines:\ %L
set statusline+=\ buffer:\ %n

" split settings
set splitbelow " open vertical split below
set splitright " open horizontal split to the right
" set fillchars=vert:| " need to research this

" use very magic mode by default for searching
nnoremap / /\v

" Indent with tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <

"tab navigation
nnoremap <leader>j :tabnext<CR>
nnoremap <leader>k :tabprev<CR>

" split/window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>N :vertical resize 32<CR>

" terminal fun
nnoremap <leader>t :terminal<CR>

" folding
set foldmethod=indent
set foldlevel=99
" fold with space
nnoremap <space> za

" fzf settings
let g:fzf_layout = { 'down': '-40%' }
nnoremap <leader>f :Ag <C-R><C-W><cr>
vnoremap <leader>f y:Ag <C-R><cr>
nnoremap <C-F> :Ag<Space>
" nnoremap <Leader><Leader> :Files<cr>

" set python options
au BufNewFile,BufRead *.py call SetPythonOptions()
" kite options
let g:kite_tab_complete=1
nmap <silent> <buffer> K <Plug>(kite-docs)

" set web development options
au BufNewFile,BufRead *.js, *.html, *.css call SetWebDevOptions()

" set groovy options
au BufNewFile,BufRead *Jenkinsfile call SetGroovyOptions()

augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! SetGroovyOptions()
    set filetype=groovy
endfunction

function! SetPythonOptions()
    set fileformat=unix
    let g:pymode_python='python3'
    let g:pymode_options_max_line_length=119
    let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
    let g:pymode_virtualenv=1
    let g:pymode_run_bind='<leader>r'
    let g:pymode_rope_completion=0
    let g:pymode_doc_bind='<C->k'
    let g:pymode_doc=0
    let g:pymode_folding=0
    let g:SimplyFold_docstring_preview=1
    let g:SimplyFold_fold_import=0
endfunction

function! SetWebDevOptions()
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction

function! HelpInNewTab()
    if &buftype == 'help'
        "Convert the help window to a tab..."
        execute "normal \<C-W>T"
    endif
endfunction

" NERDTree options
map <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=32

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
