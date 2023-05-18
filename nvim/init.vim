"  Plugins
" ---------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
" plugins that provide or manage splits
Plug 'preservim/nerdtree'
Plug 'kincerb/nerdtree-git-plugin'
" file icons
Plug 'ryanoasis/vim-devicons'
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-peekaboo' " displays split with all registers
" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" plugins for git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" autocomplete
Plug 'neoclide/coc.nvim' , { 'branch' : 'release'  }
Plug 'mbbill/undotree'
" syntax highlighting, code display
Plug 'pseewald/vim-anyfold'
Plug 'frazrepo/vim-rainbow'
Plug 'lukas-reineke/indent-blankline.nvim' " show vertical line at each indent level
Plug 'tpope/vim-rhubarb'
Plug 'ap/vim-css-color'
" formatting
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
" find all the things
Plug 'junegunn/fzf', { 'dir': '~/.local/fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
" code completion / navigation
Plug 'andymass/vim-matchup'
Plug 'jiangmiao/auto-pairs' " basic auto-close
Plug 'tpope/vim-endwise' " auto-close for shells, ruby
Plug 'alvan/vim-closetag' " auto-close html
" syntax highlighting for kitty conf files
Plug 'fladson/vim-kitty'

" general UI stuff
Plug 'rcarriga/nvim-notify'
call plug#end()

filetype plugin indent on
syntax enable

set background=light
set termguicolors
colorscheme PaperColor " prev: molokai

" add fzf to vim runtimepath
set rtp+=~/.local/fzf
set rtp+=~/.local/venvs/neovim
let g:python3_host_prog = '~/.local/venvs/neovim/bin/python3'

" Highlight colors for matchpairs
hi Normal guibg=NONE ctermbg=NONE
hi Folded guifg=#000000 guibg=#616161
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE guifg=#89858c
hi CursorLineNr guibg=#89858c ctermbg=NONE guifg=#d5d4d6
hi ColorColumn guibg=NONE
hi CursorLine gui=underline cterm=underline
hi VertSplit guibg=#005f87 guifg=#005f87
hi SignColumn guibg=NONE ctermbg=NONE
hi MatchParen guibg=#b3b0b5 guifg=#9805ed
hi CocMenuSel guibg=#bdbfa3 guifg=#346b69 gui=bold
" autocmd ColorScheme * hi CocMenuSel guifg=#243e4f gui=nocombine
hi IndentBlanklineIndent1 guifg=#6b1c18 gui=nocombine
hi IndentBlanklineIndent2 guifg=#E5C078 gui=nocombine
hi IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
hi IndentBlanklineIndent4 guifg=#F56451 gui=nocombine
hi IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
hi IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
hi GitGutterChange guifg=NONE guifg=#1c3757 gui=nocombine
hi GitGutterAdd guibg=NONE guifg=#1b5e24 gui=nocombine
hi GitGutterDelete guibg=NONE guifg=#380c0c gui=nocombine

"------- Autocommands  --------"
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * wincmd p
autocmd CompleteDone * if !pumvisible() | pclose | endif
autocmd BufNewFile,BufRead *Jenkinsfile :set filetype=groovy
autocmd BufNewFile,BufRead *.yml :set filetype=yaml.ansible " create function or script to inspect first line
autocmd FileType * AnyFoldActivate
autocmd FileType javascript setlocal commentstring=/*%s*/
autocmd CursorHold * silent call CocActionAsync('highlight')

augroup json_files
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

augroup neovim_terminal
    autocmd!
    autocmd TermOpen * startinsert
    autocmd TermOpen * :set nonumber norelativenumber
    " allows you to use Ctrl-c on terminal window
    " autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

"------- VIM variables --------"
let mapleader="\<Space>"
set clipboard^=unnamedplus " use system register
" set fillchars=vert:|
set splitright
set splitbelow
" autocomplete settings
set completeopt+=menuone   " show the popup menu even when there is only 1 match
set completeopt+=noinsert  " don't insert any text until user chooses a match
set completeopt+=noselect  " force user selection
set completeopt-=longest   " don't insert the longest common text
set belloff+=ctrlg         " disable beep during completion

set cursorline
set cursorlineopt=number
set noswapfile
set directory=~/.local/share/nvim/tmp
set undodir=~/.local/share/nvim/undodir
set undofile
set nobackup
set diffopt=vertical,filler
set nowritebackup
set colorcolumn=120
set updatetime=300
set shortmess+=c
set signcolumn=auto
set scrolloff=16
set showmatch
set number
set relativenumber
set history=500
" search settings
set ignorecase
set smartcase
set incsearch " hightlight match while typing
set nohlsearch
set encoding=utf-8
set cmdheight=1
set hidden " don't warn when switching from unsaved buffer
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start "allow backspace to delete as expected
set pastetoggle=<F2>
set conceallevel=3
" statusline
set laststatus=2
set showtabline=2
set foldlevel=99 " start with all folds opened
" display extra whitespace
set list listchars=tab:⟾●,trail:◎,nbsp:●

"------- Builtin variables --------"
let g:netrw_keepdir=0
let g:netrw_winsize=30
let g:netrw_banner=0

"------- Plugin variables --------"
let g:airline_powerline_fonts=1
let g:airline_highlighting_cache=1
let g:airline_skip_empty_sections=1
let g:airline_exclude_preview = 0
" Need to set these after the dictionary has been created
" let g:airline_symbols.dirty=' '
" let g:airline_symbols.notexists=' '
let g:airline_theme='papercolor'
let g:airline#extensions#coc#enabled=1
let g:airline#extensions#coc#show_coc_status=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#ignore_bufadd_pat='nerd_tree|tagbar|buffhidden|quickfix|hidden'
let airline#extensions#coc#error_symbol=''
let airline#extensions#coc#warning_symbol=''

let g:gitgutter_sign_modified='󰜥'
let g:gitgutter_sign_added=''
let g:gitgutter_sign_removed=''
let g:gitgutter_git_args='--no-optional-locks'
let g:anyfold_fold_display=0
let g:anyfold_fold_comments=2
let g:anyfold_fold_toplevel=0
let g:anyfold_motion=1

let g:indentLine_setConceal=1 " set to 0 to disable plugin overriding conceal options
let g:indentLine_fileTypeExclude = ['markdown']

let g:NERDTreeGitStatusConcealBrackets=0
let NERDTreeIgnore=['\.pyc$', '\~$', '\.swp$', '\.ropeproject$', '\.git$', '\.idea$']
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeWinSize=32
let NERDTreeHijackNetrw=1

let python_highlight_all=1
let g:rainbow_active=1

let g:fzf_action = { 'enter': 'edit', 'ctrl-t': 'tab split', 'ctrl-s': 'vsplit', 'ctrl-i': 'split'}
" let g:fzf_layout = { 'down': '40%' }
let g:fzf_buffers_jump = 1
let g:coc_filetype_map = {
    \ 'jinja.html': 'htmldjango',
    \ 'yaml.ansible': 'ansible',
    \ }

let g:coc_disable_startup_warning = 1

let g:coc_global_extensions = [ '@yaegassy/coc-pylsp', '@yaegassy/coc-ruff',
    \ 'coc-json', 'coc-marketplace',
    \ 'coc-yaml', 'coc-sh', 'coc-vimlsp', '@yaegassy/coc-ansible',
    \ 'coc-go', 'coc-snippets', 'coc-htmldjango', 'coc-docker',
    \ 'coc-css', 'coc-html', 'coc-markdownlint' ]

let g:indent_blankline_char_highlight_list = [
    \ 'IndentBlanklineIndent1',
    \ 'IndentBlanklineIndent2',
    \ 'IndentBlanklineIndent3',
    \ 'IndentBlanklineIndent4',
    \ 'IndentBlanklineIndent5',
    \ 'IndentBlanklineIndent6']

let g:indent_blankline_buftype_exclude = [
    \ 'terminal',
    \ 'help',
    \ 'nofile',
    \ 'quickfix',
    \ 'prompt']

"------- Keymaps --------"
nnoremap <expr> <CR> &diff ? ']c' : ':noh'
" nnoremap <CR> :noh
nnoremap <expr> <leader>x ':tabclose<CR>'
nnoremap <leader><leader> za
nnoremap <leader>z zA
inoremap jk <ESC>
inoremap <C-o> <ESC>o<ESC>
" use very magic mode by default for searching
nnoremap / /\v
" Indent with tab
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >
vnoremap <S-Tab> <
" reload vimrc
nnoremap <leader><F5> :source $MYVIMRC<CR>

nnoremap v <C-V>
nnoremap <C-V> v

"------- Keymaps for navigation --------"
nnoremap <leader>j :tabnext<CR>
nnoremap <leader>k :tabprev<CR>
" split/window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>= :vertical resize 42<CR>
" terminal mappings
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :split term://bash<CR>

" quickfix list navigation
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>

"------- Keymaps for plugins --------"
nnoremap <leader>gl :0Gclog<CR>
vmap <leader>gl :Gclog<CR>
nnoremap <leader>gf :Gdiffsplit!<CR>
nnoremap <expr> <leader>ga WriteAndAdd()
nnoremap <leader>gR :Git rebase --continue<CR>
nnoremap <leader>gP :silent Git push<CR>
nnoremap <leader><C-n> :TagbarToggle<CR>
nnoremap <leader>n :NERDTreeMirror<CR>:NERDTreeFocus<CR>
nnoremap <leader>N :NERDTreeClose<CR>

nnoremap <F5> :UndotreeToggle<CR>
" search for word under cursor
nnoremap <leader>f :Ag <C-R><C-W><cr>
" [visual] search for word under cursor
vnoremap <leader>f y:Ag <C-R><cr>
" enter search pattern
nnoremap <leader>/ :Ag<Space>
" search vim command history
nnoremap <leader>h :History:<CR>
" normal mode mappings
nnoremap <leader>? :Maps<CR>
nnoremap <leader>. :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>c :Commands<CR>
nnoremap <leader>bt :BTags<CR>
nnoremap <expr> <leader>C ConstructCommit()

nmap == <Plug>(coc-codeaction-line)
vmap == <Plug>(coc-codeaction-selected)
xmap == <Plug>(coc-codeaction-selected)
nmap <leader>qf <Plug>(coc-fix-current)
" goto mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-format)
vmap <leader>r <Plug>(coc-format-selected)
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Run Code Lens on current line
nmap <leader>cl <Plug>(coc-codelens-action)
nmap =r <Plug>(coc-rename)
vmap =r <Plug>(coc-rename)
nmap =f <Plug>(coc-format-selected)
xmap =f <Plug>(coc-format-selected)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug> (coc-funcobj-i)
xmap af <Plug> (coc-funcobj-a)
omap if <Plug> (coc-funcobj-i)
omap af <Plug> (coc-funcobj-a)
" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ CheckBackSpace() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold :call CocAction('fold', <f-args>)
command! -nargs=0 Org :call CocAction('runCommand', 'editor.action.organizeImport')

function! WriteAndAdd() abort
    return ":Gwrite! |:Git add % \<CR>\<CR>"
endfunction

function! ConstructCommit() abort
    let branch = FugitiveHead()
    if branch =~ 'MWAUTO'
        return ":Git commit % -m \"" . branch . " #comment \"\<Left>"
    endif
    return ":Git commit % -m \"\"\<Left>"
endfunction

function! HelpInNewTab()
    if &buftype == 'help'
        "Convert the help window to a tab..."
        execute "normal \<C-W>T"
    endif
endfunction

function! ShowDocumentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        " execute '!' . &keywordprg . " " . expand('<cword>')
        call feedkeys('K', 'in')
    endif
endfunction

function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Update to take filter argument
function! PasteIntoTermBuffer(term_type) range
    let term_buffer_num = bufnr(a:term_type)
    if term_buffer_num == -1
        return
    endif
    " call term_sendkeys(term_buffer_num, "\<C-R>\<C-W>")
endfunction

function! SetShortTabs()
    setlocal shiftwidth=2
    setlocal tabstop=2
    setlocal softtabstop=2
    " setlocal conceallevel=0
endfunction

function! SetMarkdownOptions()
    setlocal conceallevel=3
    setlocal concealcursor=""
endfunction

function! SetPythonOptions()
    let b:AutoPairs = AutoPairsDefine({"f'" : "'", "r'" : "'", "b'" : "'"})
    setlocal formatprg=black\ --line-length\ 120\ --quiet
    iabbrev <buffer> ifmain if __name__ == "__main__":<cr><tab>main()<cr><esc>
endfunction

function! NERDTreeHighlightFile(extension, guifg, guibg)
    exec 'autocmd FileType nerdtree highlight ' . a:extension .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashrc', '#686868', 'none')
" call NERDTreeHighlightFile('bashprofile', '#686868', 'none')

augroup Markdown
    autocmd!
    au BufNewFile,BufRead *.md call SetMarkdownOptions()
augroup END

augroup ShortTabs
    autocmd!
    au BufNewFile,BufRead *.js,*.ts,*.html,*.css,*.yml,*.json,*.toml call SetShortTabs()
augroup END

augroup HelpInTabs
    autocmd!
    autocmd BufEnter *.txt call HelpInNewTab()
augroup END

augroup Python
    autocmd!
    autocmd FileType python call SetPythonOptions()
augroup END

if exists('g:loaded_webdevicons')
    let g:webdevicons_conceal_nerdtree_brackets=1
    " let g:WebDevIconsNerdTreeGitPluginForceVAlign=1
    call webdevicons#refresh()
endif
