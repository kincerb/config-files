" bootstrap vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent let hostname = system('echo -n $HOSTNAME') 
if hostname == "NW199884"
    set pythonthreedll=/Library/Frameworks/Python.framework/Versions/3.9/lib/libpython3.9.dylib
endif

set nocompatible
filetype off

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'pseewald/vim-anyfold'
Plug 'google/yapf'
Plug 'tpope/vim-commentary'
Plug 'nvie/vim-flake8'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'frazrepo/vim-rainbow'
Plug 'yggdroot/indentline'
Plug 'othree/html5.vim'
Plug 'majutsushi/tagbar'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
call plug#end()

" add fzf to vim runtimepath
set rtp+=~/.fzf
set background=dark
colorscheme gruvbox
autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
autocmd ColorScheme * hi LineNr guibg=NONE ctermbg=NONE
autocmd ColorScheme * hi SignColumn guibg=NONE ctermbg=NONE
autocmd ColorScheme * hi CursorLine term=underline,nocombine cterm=underline,nocombine gui=underline,nocombine ctermbg=NONE guibg=NONE
autocmd ColorScheme * hi Folded term=strikethrough,nocombine cterm=strikethrough,nocombine gui=strikethrough,nocombine ctermbg=NONE guibg=NONE
filetype on
filetype plugin indent on
syntax enable
set cursorline
set showmatch
set number
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
let mapleader=" "

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
" start recommended coc.nvim settings
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c
" end recommended coc.nvim settings

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
nnoremap <leader>= :vertical resize 32<CR>

" terminal fun
nnoremap <leader>t :terminal<CR>

" folding
set foldmethod=indent
set foldlevel=99
" fold with space
nnoremap <leader><leader> za
" anyfold
autocmd Filetype * AnyFoldActivate
let g:anyfold_motion=0
let g:anyfold_fold_display=0

let g:rainbow_active=1

" fzf settings
let g:fzf_action = { 'enter': 'tab split', 'ctrl-x': 'split' }
nnoremap <leader>f :Ag <C-R><C-W><cr>
vnoremap <leader>f y:Ag <C-R><cr>
nnoremap <C-F> :Ag<Space>
nnoremap <leader>. :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>c :Commands<CR>

" terminal bindings
nnoremap <leader>e call term_sendkeys(buf, "import \<CR>")
vnoremap <leader>e call term_sendkeys(buf, "\<C-R>\<C-W>")

" kite options
let g:kite_supported_languages = ['python']
let g:kite_tab_complete=1
let g:kite_auto_complete=1
" let g:kite_documentation_continual=1
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt-=longest   " don't insert the longest common text
set completeopt+=preview
set belloff+=ctrlg         " disable beep during completion
autocmd CompleteDone * if !pumvisible() | pclose | endif

augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

function! HelpInNewTab()
    if &buftype == 'help'
        "Convert the help window to a tab..."
        execute "normal \<C-W>T"
    endif
endfunction

" NERDTree options
map <leader>n :NERDTreeFocus<CR>
map <leader>N :NERDTreeClose<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.ropeproject$', '\.git$', '\.idea$']
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=36

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * wincmd p

augroup WebDev
    autocmd!
    au BufNewFile,BufRead *.js,*.ts,*.html,*.css,*.yml,*.json source ~/.vim/webdev.vim
augroup END
augroup Python
    autocmd!
    au BufNewFile,BufRead *.py source ~/.vim/python.vim
augroup END
au BufNewFile,BufRead *Jenkinsfile :set filetype=groovy


python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
