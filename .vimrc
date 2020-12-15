" bootstrap vim-plug
" let $NVIM_COC_LOG_LEVEL = 'debug'
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
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn term=bold,nocombine guibg=NONE ctermbg=NONE
hi CursorLine term=underline,nocombine cterm=underline,nocombine gui=underline,nocombine ctermbg=NONE guibg=NONE
hi CursorColumn term=underline,nocombine cterm=underline,nocombine gui=underline,nocombine ctermbg=NONE guibg=NONE
hi Folded term=strikethrough,nocombine cterm=strikethrough,nocombine gui=strikethrough,nocombine ctermbg=NONE guibg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi Normal guibg=NONE ctermbg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi LineNr guibg=NONE ctermbg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi SignColumn term=bold,nocombine guibg=NONE ctermbg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi CursorLine term=underline,nocombine cterm=underline,nocombine gui=underline,nocombine ctermbg=NONE guibg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi CursorColumn term=underline,nocombine cterm=underline,nocombine gui=underline,nocombine ctermbg=NONE guibg=NONE
autocmd BufEnter,BufNewFile,BufRead,SourcePost * hi Folded term=strikethrough,nocombine cterm=strikethrough,nocombine gui=strikethrough,nocombine ctermbg=NONE guibg=NONE
filetype on
filetype plugin indent on
syntax enable
set cursorline
set showmatch
set number
set relativenumber
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

" reload vimrc
nnoremap <leader><F5> :source $MYVIMRC<CR>

" remove conceal option for json files to show quotes
let g:vim_json_conceal=0

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
let g:fzf_action = { 'enter': 'tab split', 'ctrl-s': 'vsplit', 'ctrl-i': 'split'}
" temporarily prevent powerline from crashing by not using the popup window
let g:fzf_layout = { 'down': '40%' }
" jump to window if possible
let g:fzf_buffers_jump = 1
" search for word under cursor
nnoremap <leader>f :Ag <C-R><C-W><cr>
" [visual] search for word under cursor
vnoremap <leader>f y:Ag <C-R><cr>
" enter search pattern
nnoremap <C-F> :Ag<Space>
" search vim command history
nnoremap <leader>h :History:<CR>
" normal mode mappings
nnoremap <leader>? :Maps<CR>
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

" NERDTree options
map <leader>n :NERDTreeFocus<CR>
map <leader>N :NERDTreeClose<CR>
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.ropeproject$', '\.git$', '\.idea$']
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=36

function! HelpInNewTab()
    if &buftype == 'help'
        "Convert the help window to a tab..."
        execute "normal \<C-W>T"
    endif
endfunction

function! s:show_coc_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction   

function! SetWebDevOptions()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
    syntax enable

    " Use tab for trigger completion with characters ahead and navigate.
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config.
    inoremap <buffer><silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <buffer><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    let g:coc_global_extensions = [ 'coc-tsserver', 'coc-tslint-plugin', 'coc-prettier', 'coc-angular', 'coc-json', 'coc-css', 'coc-html' ]
    " let g:coc_suggest_disable=1
    " let g:kite_supported_languages = ['*']
    nmap <buffer> == <Plug>(coc-codeaction)
    vmap <buffer> == <Plug>(coc-codeaction-selected)
    xmap <buffer> == <Plug>(coc-codeaction-selected)
    nmap <buffer> <leader>qf <Plug>(coc-fix-current)
    imap <buffer><silent><expr> <Tab> coc#refresh()
    imap <buffer><silent><expr> <c-@> coc#refresh()
    " goto mappings
    nmap <buffer><silent> gd <Plug>(coc-definition)
    nmap <buffer><silent> gy <Plug>(coc-type-definition)
    nmap <buffer><silent> gi <Plug>(coc-implementation)
    nmap <buffer><silent> gr <Plug>(coc-references)
    nmap <buffer> <leader>r <Plug>(coc-format)
    vmap <buffer> <leader>r <Plug>(coc-format-selected)
    imap <silent><expr><buffer> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent><buffer> [g <Plug>(coc-diagnostic-prev)
    nmap <silent><buffer> ]g <Plug>(coc-diagnostic-next)

    nmap <buffer> =r <Plug>(coc-rename)
    vmap <buffer> =r <Plug>(coc-rename)

    " Use K to show documentation in preview window.
    nmap <silent><buffer> K :call <SID>show_coc_documentation()<CR>
endfunction

function! SetPythonOptions()
    syntax enable
    let b:pymode_python='python3'
    let b:pymode_options_max_line_length=119
    let b:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
    let b:pymode_virtualenv=1
    let b:pymode_run_bind='<leader>E'
    let b:pymode_rope_completion=0
    let b:pymode_doc_bind='<C->k'
    let b:pymode_doc=0
    let b:pymode_folding=0
    let b:pymode_rope=1
    let b:pymode_rope_goto_definition_bind='<leader>g'
    let b:pymode_rope_rename_bind = '<leader>r'
    let b:pymode_rope_goto_definition_cmd='new'
    nmap <silent><buffer> K <Plug>(kite-docs)
endfunction

augroup WebDev
    autocmd!
    au BufNewFile,BufRead *.js,*.ts,*.html,*.css,*.yml,*.json call SetWebDevOptions()
augroup END

augroup Python
    autocmd!
    au BufNewFile,BufRead *.py call SetPythonOptions()
augroup END
augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * wincmd p
autocmd CompleteDone * if !pumvisible() | pclose | endif
autocmd BufNewFile,BufRead *Jenkinsfile :set filetype=groovy

python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
