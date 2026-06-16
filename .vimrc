syntax on
filetype plugin indent on
" colorscheme desert

" Yank to system clipboard
nnoremap y :<C-u>call system('wl-copy', @")<CR>y
nnoremap yy :<C-u>call system('wl-copy', getline('.'))<CR>
vnoremap y :<C-u>call system('wl-copy', @")<CR>y

" Put from system clipboard
nnoremap p :<C-u>let @"=system('wl-paste', '')<CR>p
nnoremap P :<C-u>let @"=system('wl-paste', '')<CR>P

" relative line number
"set relativenumber
