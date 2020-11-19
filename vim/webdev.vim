setlocal shiftwidth=2
setlocal tabstop=2
setlocal softtabstop=2

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <buffer><silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <buffer><expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-eslint', 'coc-prettier', 'coc-angular', 'coc-json', 'coc-css' ]
nmap <buffer> <leader><CR> <Plug>(coc-codeaction)
nmap <buffer> <leader>qf <Plug>(coc-fix-current)
inoremap <silent><expr> <Tab> coc#refresh()
inoremap <silent><expr> <c-@> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <buffer> <leader>r <Plug>(coc-format)
vmap <buffer> <leader>r <Plug>(coc-format-selected)
inoremap <silent><expr><buffer> <cr> pumvisible() ? coc#_select_confirm()
                          \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent><buffer> [g <Plug>(coc-diagnostic-prev)
nmap <silent><buffer> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent><buffer> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
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

