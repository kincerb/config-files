"  Plugins
" ---------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
" plugins that provide or manage splits
Plug 'preservim/nerdtree'
Plug 'kincerb/nerdtree-git-plugin'
" file icons
Plug 'majutsushi/tagbar'
Plug 'junegunn/vim-peekaboo' " displays split with all registers
" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" plugins for git
Plug 'tpope/vim-fugitive'
" autocomplete
Plug 'neovim/nvim-lspconfig'
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
Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' } " ansible syntax
" syntax highlighting for kitty conf files
Plug 'fladson/vim-kitty'

