set paste
set ruler
set number

nmap <C-t> :tabnew<CR>

" Go to last active tab

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

syntax enable


" Always show statusline
set laststatus=2

colorscheme monokai

hi! Search cterm=NONE,reverse gui=NONE,reverse ctermfg=3 guifg=#b58900 ctermbg=NONE guibg=NONE

hi! link Todo YellowR

" Powerline
set rtp+=$HOME/.local/lib/python2.6/site-packages/powerline/bindings/vim/
